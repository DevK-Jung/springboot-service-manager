#!/bin/bash

# 서비스 관련 설정
SERVICE_NAME="serviceName"     # 서비스명 (원하는 서비스 이름으로 변경)
PATH_TO_JAR="jarFilePath"      # 실행할 JAR 파일의 경로
PID_PATH_NAME="pidFilePath"    # PID를 저장할 파일 경로
PROFILE="-Dspring.profiles.active=dev" # Spring Boot 프로파일 설정
JAVA_PATH="javaPath"           # Java 실행 파일 경로

# 서비스 시작 함수
start_service() {
    echo "🚀 $SERVICE_NAME 서비스를 시작합니다..."

    # PID 파일이 없으면 생성
    if [ ! -f "$PID_PATH_NAME" ]; then
        touch "$PID_PATH_NAME"
    fi

    # 서비스가 이미 실행 중인지 확인
    if [ -s "$PID_PATH_NAME" ]; then
        echo "⚠️ $SERVICE_NAME이 이미 실행 중입니다. (PID: $(cat $PID_PATH_NAME))"
    else
        nohup "$JAVA_PATH" -jar $PROFILE "$PATH_TO_JAR" >> /dev/null 2>&1 &
        echo $! > "$PID_PATH_NAME"
        echo "✅ $SERVICE_NAME이 시작되었습니다. (PID: $(cat $PID_PATH_NAME))"
    fi
}

# 서비스 중지 함수
stop_service() {
    if [ -f "$PID_PATH_NAME" ] && [ -s "$PID_PATH_NAME" ]; then
        PID=$(cat "$PID_PATH_NAME")
        echo "🛑 $SERVICE_NAME (PID: $PID)을 중지합니다..."
        kill "$PID"
        rm -f "$PID_PATH_NAME"
        echo "✅ $SERVICE_NAME이 중지되었습니다."
    else
        echo "⚠️ $SERVICE_NAME이 실행 중이지 않습니다."
    fi
}

# 서비스 재시작 함수
restart_service() {
    echo "🔄 $SERVICE_NAME을 재시작합니다..."
    stop_service
    start_service
}

# 실행 명령 처리
case "$1" in
    start) start_service ;;
    stop) stop_service ;;
    restart) restart_service ;;
    *)
        echo "❌ 사용법: $0 {start|stop|restart}"
        echo ""
        echo "📝 명령어 설명:"
        echo "  start   - 서비스 시작"
        echo "  stop    - 서비스 중지"
        echo "  restart - 서비스 재시작"
        echo ""
        echo "📌 예시:"
        echo "  ./service.sh start   # 서비스 시작"
        echo "  ./service.sh stop    # 서비스 중지"
        echo "  ./service.sh restart # 서비스 재시작"
        exit 1
        ;;
esac
