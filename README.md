# springboot-service-manager

해당 스크립트는 특정 서비스(JAR 파일로 실행되는 애플리케이션 등)를 간편하게 실행, 중지 및 재시작할 수 있도록 도와줍니다.

## 📌 사용법

```sh
./service-manager.sh {start|stop|restart}
```

### 🔹 명령어 설명

- `start`   : 서비스를 시작합니다.
- `stop`    : 실행 중인 서비스를 중지합니다.
- `restart` : 서비스를 중지한 후 다시 시작합니다.

### 📌 실행 예시

```sh
./service-manager.sh start   # 서비스 시작
./service-manager.sh stop    # 서비스 중지
./service-manager.sh restart # 서비스 재시작
```

## ⚙️ 환경 변수 설정

스크립트에서 설정해야 하는 변수들은 다음과 같습니다:

| 변수명          | 설명                                      |
|---------------|-----------------------------------------|
| `SERVICE_NAME` | 서비스의 이름 (예: MyService)             |
| `PATH_TO_JAR`  | 실행할 JAR 파일의 경로                    |
| `PID_PATH_NAME`| PID를 저장할 파일 경로                    |
| `PROFILE`      | Spring Boot 프로파일 설정 (예: `-Dspring.profiles.active=dev`) |
| `JAVA_PATH`    | Java 실행 파일 경로 (예: `/usr/bin/java`)  |


## 🚀 실행 흐름

1. `start` 실행 시:
   - `PID_PATH_NAME` 파일이 존재하지 않으면 생성합니다.
   - 서비스가 실행 중이지 않다면 JAR 파일을 백그라운드에서 실행합니다.
   - 실행 후 `PID_PATH_NAME`에 프로세스 ID(PID)를 저장합니다.

2. `stop` 실행 시:
   - `PID_PATH_NAME`에서 PID를 읽어 해당 프로세스를 종료합니다.
   - 종료 후 `PID_PATH_NAME` 파일을 삭제합니다.

3. `restart` 실행 시:
   - 기존 실행 중인 서비스를 중지한 후 다시 시작합니다.

## ⚠️ 주의사항

- `PID_PATH_NAME` 파일이 올바르게 설정되지 않으면 프로세스 관리가 어려울 수 있습니다.
- 실행 권한을 부여해야 합니다:

  ```sh
  chmod +x service-manager.sh
  ```

- Java 및 JAR 파일 경로가 올바르게 설정되어 있는지 확인하세요.


