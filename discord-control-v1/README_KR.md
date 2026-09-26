# 거래소 Discord 원격 관제 V1

## 목표

집에 켜둔 Roblox + Delta 모바일을 Discord에서 확인하고 관리하는 1차 테스트 버전입니다.

### 확정된 UI

메인 메뉴:

- 🔎 장비 검색
- 📋 선택 관리
- 📦 발견 기록
- 📊 오늘 통계
- 📡 상태
- ⚙ 운영 설정

선택관리:

- 한 페이지 8개
- 목록에서는 이름만 깔끔하게 표시
- 장비 하나를 선택하면 상세화면으로 이동
- ↑ 한 칸 위 / ↓ 한 칸 아래
- 제거 전 확인
- 제거해도 기존 성급/긴급가 설정 보존
- 새 장비는 맨 마지막에 추가

검색:

- 한글 / 영문 / 내부 ID
- 대소문자 무시
- 띄어쓰기 무시
- 부분 검색
- 결과에는 한글명 + 영문명 + 조사 중이면 ✅만 표시

## V1 구조

```
외출 중 Discord
       |
       | Discord
       v
집 PC - bot_server.py
       |  SQLite 기록
       |
       | 같은 집 네트워크 HTTP
       v
Roblox + Delta 모바일
```

PC가 꺼지면 Discord 관제도 멈춥니다. V1 테스트 후 필요하면 API/Bot을 클라우드로 옮길 수 있습니다.

## 설치

Python 3.11+ 권장.

```powershell
cd discord-control-v1
py -m pip install -r requirements.txt
```

`.env.example`을 복사해서 `.env`로 만들고 값을 입력합니다.

중요: Discord Bot Token과 AGENT_TOKEN은 절대로 GitHub에 올리지 않습니다.

AGENT_TOKEN 생성 예:

```powershell
py -c "import secrets; print(secrets.token_urlsafe(32))"
```

실행:

```powershell
py bot_server.py
```

정상 실행되면:

```
API listening on 0.0.0.0:8765
Discord bot ready
```

## 첫 테스트 순서

1. Discord Bot을 서버에 초대
2. PC에서 `bot_server.py` 실행
3. Discord에서 `/관제` 실행
4. 메인 관제판이 뜨는지 확인
5. 같은 집 Wi-Fi의 모바일에서 PC API에 접근 가능한지 확인
6. 그 다음 Delta Agent를 V3.4.2/3에 연결

처음부터 스캐너 설정을 원격 변경하지 않습니다. 먼저 상태 통신 -> 카탈로그 -> 발견 기록 -> 원격 명령 순서로 하나씩 테스트합니다.
