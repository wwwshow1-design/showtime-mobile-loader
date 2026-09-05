-- 쇼타임 통합 자동팜 V3.9 모바일 UI 조작성 개선 시험본
-- V3.8 모바일 기준본의 게임·자동화 기능은 유지하고 UI 조작성만 개선합니다.
-- 모바일 제목바 드래그, 자동팜 뒤로가기·독립 축소, 목록 마지막 항목 접근성을 추가합니다.
-- 모바일 목록은 AutomaticCanvasSize와 넉넉한 하단 여백을 사용하고 강제 Scroll Snap을 해제합니다.
-- 모바일 UI 추가: Samsung Galaxy Note10+ 세로 화면을 기준으로 구성했습니다.
-- 세로모드 우선 반응형 UI이며 화면 회전·분할 화면·다른 Android 해상도에도 자동 재배치합니다.
-- 터치 버튼과 닫기 버튼을 확대하고, 차량 목록은 모바일에서 2열 카드로 표시합니다.
-- 팝업은 화면의 가로 92%·세로 82% 안에서 맞추며 긴 내용은 기존 스크롤 영역을 사용합니다.
-- PC에서는 기존 V3.7 UI 크기와 배치를 유지하고 게임 기능·자동화 연결은 변경하지 않습니다.
-- V3.6 정식본 기준으로 기존 화면 클릭식 스핀을 제거하고 내부 상태 기반 실행·수령으로 교체합니다.
-- 비정상 종료 복구 알림의 시작 레벨은 저장 당시 값이 아니라 재접속 시 실제 차량 레벨로 다시 확인합니다.
-- 기준: 쇼타임 통합 자동팜 V1.4 전체탭·등급사진 시험본
-- 시험 변경: 보유차량 창을 열 때 게임 차량 자료를 화면 뒤에서 1회 자동 준비하고, 3열 x 2줄 정적 카드로 표시합니다.
-- 같은 VehicleId/Level의 차량도 서로 다른 보유 UUID라면 합치지 않고 각각 표시합니다.
-- 작은 UI의 미작동 '선택 차량 없음' 표시를 제거하고 현재 작업/차량 대기열 탭을 추가합니다.
-- Limited/한정판은 빨간 배경, 5성은 큰 발광 별, 1~4성은 작은 세로 별로 구분합니다.
-- 목표 레벨 0은 자동 완료·정지·다음 차량 전환이 없는 무제한 파밍으로 사용합니다.
-- 좌클릭/F의 표적과 횟수를 분리하고 SuperRazor형 좌클릭 유도탄 직접발사를 지원합니다.
-- 시험 변경: 자동팜·AFK 패드·일반 대기 중 모두 5분마다 자리비움 방지 입력을 보냅니다.
-- 기본값은 켜짐이며, Roblox Idled 이벤트는 같은 입력 함수를 호출하는 즉시 보조 안전장치입니다.
-- AFK 패드 보상 수집과 자리비움 방지는 한 반복문에서 관리하여 중복 반복을 만들지 않습니다.
-- main 정식본은 변경하지 않으며 실게임 검증 전에는 정식 승격하지 않습니다.
-- V1.1 UI 검증을 완료한 통합 정식 기준본이며 기존 V1.0 정식본은 이전 버전으로 보존합니다.
-- 점령·스핀·AFK가 메인이고 자동팜은 사용자가 버튼을 눌렀을 때만 불러옵니다.
-- 자동팜 X는 기능을 정지하지 않고 통합 작은 UI로 돌아갑니다.
-- 자동팜 정지 시 확인창을 표시하고, 자동팜만 정지하면 5초 후 AFK로 복귀합니다.
-- 자동팜은 기본 15FPS, 스핀 처리 중 30FPS로 임시 전환한 뒤 다시 15FPS로 복귀합니다.
-- 무료 스핀은 차량 자동팜을 잠시 멈춘 뒤 우선 처리하고 완료 후 자동 재개합니다.
-- 작은 UI는 화면 가운데 표시하며 서버 종류, 현재 다이아, 수익과 작업 상태를 표시합니다.
-- 현재 다이아는 기존 V8.0 기지 전광판 기준이며 별도 실시간 다이아 추적은 다음 시험에서 진행합니다.

--[[
==================================================
점령 방치 스핀
버전: V8.0
업데이트 날짜: 2026-08-29

이번에 고친 내용

V8.0 구조 정리 및 탭별 UI 정식본

V8.0 정식본 확정

1. 구조 정리 후 기존 기능 전체가 정상 작동함을 확인했습니다.

2. 문법 오류와 Refresh nil 오류를 수정했습니다.

3. 확대 UI 탭별 자동 높이 기능이 정상 작동함을 확인했습니다.

4. 이 파일을 V8.0 정식 기준본으로 사용합니다.


V8.0 탭별 높이 자동 조절 4

1. 설정 탭의 아래쪽 버튼이
   확대창 배경 밖으로 나오는 문제를 수정했습니다.

2. 작업, 이동, 스핀 탭은
   높이 252의 짧은 창을 사용합니다.

3. 설정 탭은 버튼이 많으므로
   높이 304의 긴 창을 자동으로 사용합니다.

4. 탭을 바꿀 때마다 창 높이와 중앙 위치를
   선택한 탭에 맞게 자동 조절합니다.

5. 기존 버튼 기능과 배치는 변경하지 않았습니다.


V8.0 확대 UI 정리 3

1. 기존 작업, 이동, 설정, 스핀 탭과
   모든 버튼 기능은 그대로 유지했습니다.

2. 확대창 높이를 360에서 252로 줄여
   아래쪽의 큰 빈 공간을 제거했습니다.

3. 내부 표시 비율을 0.78에서 0.86으로 높여
   글씨와 버튼을 조금 더 크고 선명하게 보이도록 했습니다.

4. 확대창 중심 위치를 새 높이에 맞게 조정했습니다.

5. 기능 코드는 변경하지 않았습니다.


V8.0 PR 실행 오류 수정 2

1. Refresh 화면 갱신 함수에서
   테이블 연결이 빠진 상태값 6곳을 수정했습니다.

2. 오류 문구
   attempt to concatenate string with nil

3. 쉬운 한글 뜻
   화면 문장을 만들 때 글자와 비어 있는 값을
   서로 붙이려고 해서 실패했다는 뜻입니다.

4. 수정 항목
   최근 다이아 변경 시간
   스핀 상태 2곳
   마지막 스핀 시간
   다이아 상태
   AFK 보상 상태

5. 게임 기능은 변경하지 않았습니다.


V8.0 PR 긴급 문법 수정 1

1. Revenue 테이블 안의 StartDiamonds 항목이
   RuntimeState.StartDiamonds 형태로 잘못 변환된 문제를 고쳤습니다.

2. 오류 문구
   Expected '}' (to close '{'), got '='

3. 쉬운 한글 뜻
   정리함 안에 잘못된 항목 이름이 들어가서
   정리함을 정상적으로 닫을 수 없다는 뜻입니다.

4. 게임 기능은 변경하지 않았습니다.


1. 게임 기능은 새로 추가하거나 삭제하지 않았습니다.

2. 실행 중 바뀌는 상태값 약 40개를
   RuntimeState 테이블 하나로 묶었습니다.

3. 고정 설정값 약 20개를
   Settings 테이블 하나로 묶었습니다.

4. 최상위 local 사용량을 줄여
   Out of local registers / exceeded limit 200
   오류가 다시 생길 가능성을 낮췄습니다.

5. 오류의 쉬운 한글 뜻
   스크립트가 한 구역에서 사용할 수 있는
   임시 기억 공간 200칸을 모두 사용했다는 뜻입니다.

6. 이 오류가 생기면 특정 기능 하나만 고장 나는 것이 아니라
   스크립트가 시작되기 전에 멈춰
   UI와 전체 자동화가 실행되지 않을 수 있습니다.

7. V7.9 정식 기준본은 main에 그대로 보존하고
   이 파일은 별도 브랜치에서 시험합니다.


V7.0 직접 클랜 서버 입장

1. 기존 MY CLAN, CLAN SEASON, CLAN SERVER UI 클릭 방식을 제거했습니다.

2. 게임 내부에서 실제 사용하는 PlaceUtil.isClanServer()로
   현재 서버가 클랜 서버인지 직접 확인합니다.

3. 일반 서버에서는 PLAY와 일일보상 처리를 먼저 진행합니다.

4. 이후 게임 내부 ClanServerService:Join()을 직접 호출합니다.

5. 클랜 서버로 이동되어 AUTO EXECUTE가 다시 실행되면
   PlaceUtil.isClanServer()가 true이므로 Join을 다시 호출하지 않습니다.

6. 클랜 서버에서는 바로 점령 자동 시작 요청을 만듭니다.

7. 기존 1분 클랜 UI 재확인 무한 반복을 제거했습니다.

8. 클랜 서버에서만 60초 게임 UI OFF 기능이 작동하는 구조는 유지합니다.


V4.9 추가 변경

1. 다클라 화면을 덜 가리도록
   전체 UI 크기를 약 90퍼센트로 줄였습니다.

2. 스핀 시간이 멈춰 보이던 문제를 고쳤습니다.

3. 원인은 같은 NextSpin 글자를 1초마다 읽으면서
   카운트다운 기준 시간을 계속 처음으로 되돌리고 있었기 때문입니다.

4. 이제 실제 NextSpin 글자가 바뀔 때만
   기준 시간을 다시 맞춥니다.

5. 한 번 기준 시간이 잡히면
   우리 UI에서는 매초 정상적으로 카운트다운됩니다.

6. 게임 자체 NextSpin 값은
   스핀 메뉴를 열어야 최신화되는 구조라서
   30분마다 스핀 메뉴를 잠깐 열었다 닫아
   실제 시간을 다시 동기화합니다.

7. 중간에 사용자가 직접 스핀을 돌린 경우
   다음 30분 재확인 때 실제 시간을 다시 읽습니다.


V4.8 추가 변경
계정 이름 표시
주요 글씨 확대
다이아 최초 수익 +0 초기화
스핀 실제 NextSpin 값 지속 동기화
클랜 시즌 화면 기준 일반 서버와 클랜 서버 판별
일반 서버 큰 주의 표시
클랜 없는 계정 기존 진행 유지
도움말 창 완료 후 자동 닫기


1. 실행기의 AUTO EXECUTE에서 사용할 때

   74번째 줄
   WaitForChild 오류가 뜨던 문제를 고쳤습니다.

2. 원인은 로블록스가 완전히 준비되기 전에
   AUTO EXECUTE가 스크립트를 먼저 실행해서
   내 계정 정보가 아직 없는 상태였기 때문입니다.

3. 이제 스크립트가 시작되면

   로블록스 로딩 완료 확인
   내 계정 준비 확인
   PlayerGui 준비 확인

   순서로 기다린 뒤 시작합니다.

4. 직접 실행할 때도
   기존처럼 정상 작동합니다.

5. 클랜 자동 입장 기능은
   V4.6의 정상 작동 버전을 그대로 유지합니다.

6. 클랜 자동 입장 순서

   게임 화면 준비
   5초 기다림
   내 클랜 버튼 자동 클릭
   3초 기다림
   클랜 없는 계정 확인
   클랜 시즌 버튼 자동 클릭
   3초 기다림
   클랜 서버 버튼 자동 클릭

7. 일일 보상은
   오른쪽 위 X 버튼으로 자동 닫습니다.

8. 기존 기능 유지

   게임 시작 자동
   클랜 자동 입장
   일일 보상 X 자동 닫기
   이동 속도
   점령 이동
   즉시 정지
   기지 저장
   다이아 확인
   무료 스핀
   방치 방지

==================================================


V5.0 추가 변경

1. 스핀 실제 시간 재확인 주기를
   30초에서 30분으로 변경했습니다.

2. 스핀 메뉴를 계속 자주 열지 않습니다.
   로컬 카운트다운은 매초 계속 내려갑니다.

3. 다이아 총수익 시작값 오류를 다시 수정했습니다.

4. 게임 로딩 직후 다이아 전광판이 잠깐
   3 같은 잘못된 숫자를 표시하는 경우가 있었습니다.

5. 이제 같은 다이아 값이 0.5초 간격으로
   6번 연속 확인되어야 시작값으로 인정합니다.

6. 시작값이 확정되기 전에는
   총수익, 현재, 시작 값을 확인 중으로 표시합니다.

7. 시작값이 확정되는 순간
   총수익은 반드시 +0부터 시작합니다.

8. 다이아 카드 아래쪽의
   현재, 시작, 최근 글씨 크기를 키웠습니다.


V5.1 긴급 수정

1. UI가 아예 뜨지 않던 컴파일 오류를 수정했습니다.

2. 오류 문구
   Out of local registers when trying to allocate StartWork
   exceeded limit 200

3. 원인
   기능이 계속 추가되면서
   한 스크립트 안의 로컬 변수 수가 Luau 한도 200개에 도달했습니다.

4. StartWork 함수만 로컬 변수로 잡지 않도록 변경해서
   컴파일 한도 초과를 피했습니다.

5. 기능 동작 내용은 바꾸지 않았습니다.

6. V5.0에 추가한
   스핀 30분 재확인
   다이아 시작값 안정화
   글씨 확대
   클랜 자동 입장
   계정 이름 표시
   일반 서버 주의 표시
   기능은 그대로 유지합니다.


V5.2 구조 정리

1. 200개 로컬 변수 한도 문제를
   한 줄씩 땜질하지 않고 전체 구조를 정리했습니다.

2. GUI 관련 변수 약 60개를
   각각 local로 만들지 않고
   UI라는 하나의 테이블 안에 묶었습니다.

3. 예전 방식

   local Main
   local Status
   local StartButton
   local StopButton
   local ProfitCard
   local SpinCard
   ...

4. 새 방식

   UI.Main
   UI.Status
   UI.StartButton
   UI.StopButton
   UI.ProfitCard
   UI.SpinCard
   ...

5. 이 변경으로 최상위 local 개수를
   크게 줄였습니다.

6. 앞으로 기능을 더 추가해도
   200개 한도에 다시 걸릴 가능성을 줄였습니다.

7. 기존 기능은 삭제하지 않았습니다.

8. V5.1까지의 기능

   AUTO EXECUTE 초기 대기
   클랜 자동 입장
   일반 서버 주의 표시
   일일 보상 X 자동 닫기
   계정 이름 표시
   점령 자동화
   이동 속도 설정
   즉시 정지
   다이아 수익
   무료 스핀
   방치 방지
   UI 숨기기

   모두 유지합니다.


V5.3 UI 표시 오류 수정

1. V5.2에서 전체 구조를 정리하면서
   Left와 Right라는 이름을 UI 테이블로 묶었습니다.

2. 그 과정에서
   Enum.TextXAlignment.Left
   Enum.TextXAlignment.Right
   까지 실수로 바뀌었습니다.

3. 그래서 UI 바깥 틀만 만들어지고
   안쪽 글자와 버튼을 만드는 순간 오류가 나서
   화면이 빈 검은 박스로 보였습니다.

4. 이번 버전에서
   Enum.TextXAlignment.Left
   Enum.TextXAlignment.Right
   를 정상값으로 복구했습니다.

5. 200개 로컬 변수 한도 구조 정리는
   그대로 유지합니다.

6. 기존 기능도 그대로 유지합니다.


V5.4 수정

1. UI 전체 축소 90퍼센트를 해제했습니다.
   글씨가 너무 작아 보이던 문제를 수정했습니다.

2. 공통 글씨와 버튼 글씨 크기를 키웠습니다.

3. 스핀 버튼에 빨간 느낌표가 떠 있는데도
   자동 스핀이 기다리던 문제를 수정했습니다.

4. 이제 스핀 버튼 안에서
   느낌표 또는 알림 표시를 감지하면
   기존 타이머보다 우선해서
   즉시 무료 스핀 확인을 실행합니다.

5. 따라서 게임의 NextSpin 시간이
   오래된 값으로 남아 있어도
   스핀 가능 표시가 뜨면 자동으로 확인합니다.

6. 다이아 시작값과 총수익 계산 방식은
   정상 작동한 현재 방식을 유지합니다.


V5.5 추가 기능

1. X 버튼 왼쪽에 축소 버튼을 추가했습니다.

2. 축소 UI 표시 항목
   계정명
   방치시간
   상태
   총수익
   시간당 수익
   24시간 예상 수익
   다음 스핀
   현재 다이아

3. 방치시간은 점령 완료 순간부터 시작합니다.

4. 시간당 수익도 점령 완료 순간부터 계산합니다.

5. 24시간 예상 수익은 현재 시간당 수익을 기준으로 계산합니다.

6. 스핀만 00:00:00 형식을 유지합니다.

7. 점령 대기는 4분 32초처럼 초까지 표시합니다.

8. 방치시간은 5시간 52분처럼 초를 표시하지 않습니다.

9. 축소 UI 아래에 3D 렌더링과 게임 UI를
   동시에 켜고 끄는 버튼을 추가했습니다.

10. 기존 개별 3D, 게임 UI 버튼은 그대로 유지합니다.

11. 확대 버튼으로 기존 전체 UI로 돌아갑니다.

12. 전체 글씨 최소 크기를 더 키웠습니다.

13. V5.4의 스핀 알림 감지, 다이아 수익,
    클랜 자동 입장 기능은 그대로 유지합니다.


V5.6 스핀 수집 수정

1. 스핀 후 NextSpin 글자가 먼저 보이면
   수집 버튼 확인을 끝내버리던 문제를 수정했습니다.

2. 이제 스핀 결과가 나온 뒤
   수집 버튼을 가장 먼저 확인하고 클릭합니다.

3. CollectButton의 기존 경로가 달라져도
   PrizeFrame 안에서 COLLECT 이름과 글자를 추가 탐색합니다.

4. 수집 버튼이 사라진 것을 확인한 뒤
   다음 스핀 시간을 읽습니다.

5. 수집 전 느낌표가 남아
   스핀 메뉴를 계속 열고 닫던 반복 동작을 줄였습니다.

6. V5.5의 축소 UI, 방치시간,
   시간당 수익, 24시간 예상 수익,
   3D + UI 동시 버튼은 그대로 유지합니다.


V5.7 스핀 수집 버튼 수정

1. 영어 COLLECT와 한글 수집, 수집!을 모두 찾습니다.

2. 사진처럼 수집 글자가 별도 TextLabel이고
   실제 버튼이 부모 ImageButton인 구조도 처리합니다.

3. 기존 고정 경로에서 버튼을 못 찾으면
   스핀 창 전체에서 다시 탐색합니다.

4. 수집 완료 후 스핀 창이 남아 있으면
   X 버튼까지 눌러 닫습니다.

5. 수집 전 느낌표 때문에
   메뉴를 반복해서 여는 현상을 막는
   V5.6 처리도 유지합니다.


V5.8 실제 수집 버튼 경로 고정

1. F6으로 확인한 실제 수집 버튼 경로를 그대로 사용합니다.

   Spinner
   Frame
   Standard
   PrizeFrame
   Collect
   CollectButton

2. 실제 버튼 종류는 ImageButton입니다.

3. 버튼 글자는 COLLECT!로 확인했습니다.

4. 수집 버튼은 firesignal보다
   실제 마우스 클릭 방식을 먼저 사용합니다.

5. 실제 클릭이 실패할 때만
   기존 Activated 실행을 보조로 사용합니다.

6. 다음 스핀 시간 경로도
   F6으로 확인한 실제 경로로 수정했습니다.

   Spinner
   Frame
   Tabs
   NavigationFrame
   StandardSpinner
   NextSpin

7. 수집 완료 후 다음 스핀 시간을 읽고
   스핀 창을 닫는 기존 흐름은 유지합니다.


V5.9 클랜 서버 점령 자동 시작

1. 클랜 자동 입장 후
   CLAN SEASON 화면에서
   CLAN SERVER 버튼이 없는 것을 확인하면
   이미 클랜 서버로 판단합니다.

2. 클랜 서버로 확인되면
   클랜 창을 자동으로 닫습니다.

3. 그 다음 3초 기다린 뒤
   점령 시작 버튼을 누르지 않아도
   기존 점령 루틴을 자동으로 시작합니다.

4. 일반 서버에서는
   점령 자동 시작 요청을 만들지 않습니다.

5. 클랜이 없는 계정도
   점령 자동 시작 요청을 만들지 않습니다.

6. 도움말 창에는
   클랜 서버 확인
   점령 자동 시작 대기
   상태가 표시됩니다.

7. 수동 점령 시작 버튼은 그대로 유지합니다.

8. V5.8의 스핀 수집 실제 경로,
   축소 UI, 다이아 수익,
   시간당 수익 기능은 그대로 유지합니다.


V6.0 다클라 작은 창 버전

1. 실행 직후 작은 UI로 시작합니다.
2. 작은 UI 크기를 더 줄였습니다.
3. 계정명과 방치시간을 첫 줄에 유지합니다.
4. 상태, 수익, 시간당 수익, 24시간 예상 수익,
   스핀, 현재 다이아를 유지합니다.
5. 아래에는 3D + UI 버튼과 확대 버튼만 둡니다.
6. 확대하면 기존 전체 UI를 그대로 사용합니다.
7. 클랜 서버 점령 자동 시작과 기존 기능은 유지합니다.


V6.1 확대창 축소

1. 확대창도 다클라용으로 줄였습니다.
2. 전체 크기를 480 x 250 기준으로 변경했습니다.
3. 기존 기능과 버튼 배치는 유지하면서 내부 UI를 함께 축소합니다.
4. 작은창은 V6.0 크기를 그대로 유지합니다.


V6.2 세로형 확대 UI

1. 작은 Roblox 창에 맞춰 확대 UI를 세로형으로 변경했습니다.
2. 확대 UI 크기는 가로 300, 세로 330 기준입니다.
3. 기능 영역은 위쪽에 배치합니다.
4. 다이아, 스핀, 시스템 정보는 아래쪽에 배치합니다.
5. 기존 기능은 삭제하지 않고 배치만 변경했습니다.


V6.3 확대창 정보영역 수정

1. 세로형 확대 UI에서 다이아 총수익 영역이 잘리던 문제를 수정했습니다.

2. 확대창 높이를 330에서 360으로 늘렸습니다.

3. 아래쪽 다이아, 스핀, 시스템 정보 영역 높이를 늘렸습니다.

4. 오른쪽 정보 영역 글씨 스케일도 약간 키웠습니다.

5. 기존 기능과 작은창 UI는 그대로 유지합니다.


V6.4 다클라 최소 UI 개편

1. 확대창의 다이아 총수익 정보 영역을 숨겼습니다.
2. 최소창에 시작 다이아, 현재 다이아, 총수익, 시간당 수익, 24시간 예상 수익을 표시합니다.
3. 최소창에 다음 스핀, 보상 수집 횟수, 스핀 상태를 표시합니다.
4. 스핀 후 보상 이펙트를 12초 기다립니다.
5. 이후 최대 20초 동안 수집 버튼을 다시 확인합니다.
6. 확대 버튼을 최소창 상단으로 이동했습니다.
7. 빠른 작업 팝업을 추가했습니다.
8. 빠른 작업에서 작업 시작, 작업 중지, 점령 1 이동, 점령 2 이동, 자기 기지 이동을 실행합니다.
9. 설정에 60초 게임 UI 자동 OFF 버튼을 추가했습니다. 기본값은 켜짐입니다.
10. 최소창에 일반서버는 빨간색, 클랜서버는 초록색으로 표시합니다.


V6.5 빠른 작업 팝업 수정

1. 빠른 작업 버튼을 눌러도 창이 안 보이던 문제를 수정했습니다.

2. 빠른 작업 팝업을 메인 프레임 안이 아니라
   ScreenGui 바로 아래에 띄우도록 변경했습니다.

3. 팝업과 버튼 ZIndex를 높여
   다른 UI 뒤에 가려지지 않게 했습니다.

4. 오른쪽 위 X 닫기 버튼을 추가했습니다.

5. 아래쪽에도
   "아무 작업 안 함, 닫기" 버튼을 추가했습니다.

6. 확대나 축소 전환 시
   빠른 작업 팝업은 자동으로 닫힙니다.

7. 기존 빠른 작업 항목
   작업 시작
   작업 중지
   1번 점령지점 이동
   2번 점령지점 이동
   자기 기지로 이동
   기능은 그대로 유지합니다.


V6.6 장시간 방치 안전장치

1. 클랜 서버 확인 실패 또는 일반 서버면 60초 후 다시 확인합니다.
2. 클랜 서버 확인 성공 시 확인 루프를 완전히 종료합니다.
3. 클랜 없는 계정도 확인 루프를 종료합니다.
4. 점령 완료 후 기지 위치를 직접 확인합니다.
5. 기지에서 15 스터드 이내면 복귀 성공입니다.
6. 기지 복귀는 먼저 최대 3회 재시도합니다.
7. 계속 실패하면 30초마다 다시 복귀합니다.
8. 정상적으로 기지에 도착하면 복귀 루프를 완전히 종료합니다.


V6.7 클랜 입장 안전장치 수정

1. 60초 게임 UI 자동 OFF 기능은
   클랜 서버에서만 작동하도록 변경했습니다.

2. 일반 서버와 서버 확인 중 상태에서는
   게임 UI를 자동으로 끄지 않습니다.

3. 클랜 서버 자동 입장 재시도 중
   MY CLAN, CLAN SEASON 버튼을 눌러야 하기 때문입니다.

4. 클랜 서버 확인이 완료되면
   기존처럼 60초마다 게임 UI를 다시 OFF합니다.

5. 클랜 서버 1분 재확인 안전장치는 그대로 유지합니다.

6. 일일 보상 수령 버튼 문제는
   실제 버튼 경로 확인 후 다음 수정에 반영합니다.


V6.8 일일보상 수령 자동화

1. 일일보상 24시간 수령 가능 상태에서는
   X 버튼이 없고 COLLECT 버튼이 먼저 나타나는 구조를 반영했습니다.

2. 실제 확인된 수령 버튼 경로를 사용합니다.

   DailyLogin
   Frame
   Collect

3. COLLECT 버튼이 보이면
   실제 마우스 클릭을 먼저 시도합니다.

4. 수령 후 X 버튼이 생기면
   다음 자동 감시에서 X 버튼을 눌러 닫습니다.

5. 수령 전에는 X 버튼을 찾지 않습니다.

6. 기존 클랜 서버 UI OFF 조건,
   클랜 재확인,
   기지 복귀 안전장치는 그대로 유지합니다.


V7.1 직접 클랜 서버 입장 준비 대기 수정

1. AUTO EXECUTE가 너무 빨리 실행되어
   Knit와 ClanServerService가 준비되기 전에 Join을 호출하던 문제를 보강했습니다.

2. Knit와 ClanServerService를 최대 45초 기다립니다.

3. FactionId와 FactionRank가 준비될 때까지 최대 30초 기다립니다.

4. 일반 서버에서 Join을 최대 3회 시도합니다.

5. 각 Join 호출 후 최대 12초 동안 서버 이동을 기다립니다.

6. 실패하면 도움말 창에 실제 오류 문구를 표시합니다.

7. 클랜 서버로 확인되면 Join은 호출하지 않고 바로 점령 자동 시작으로 넘어갑니다.



V7.2 직접 클랜 서버 입장 + AFK 자동 수집 + FPS 설정 통합

1. V7.1의 PlaceUtil.isClanServer() 기반 서버 판별을 그대로 유지합니다.
2. 일반 서버에서는 준비 완료 후 ClanServerService:Join()을 직접 호출합니다.
3. 클랜 서버에서는 Join을 다시 호출하지 않고 바로 점령 자동 시작으로 넘어갑니다.
4. 점령 1, 점령 2 완료 후 자기 기지 복귀를 거쳐 내 기지의 AFK 사격 위치를 자동 탐색합니다.
5. AFK 위치는 PlayerTycoons > 내 계정 > Models > AfkShooting > ManualWorker > ShootForMoney를 사용합니다.
6. AFK_TICKET과 AFKScene을 기준으로 AFK 정상 진입을 확인합니다.
7. AFKShootingRewards에 보상이 생기면 실제 AFK Collect 연결을 실행합니다.
8. 수집 직전 Diamonds 수량을 읽고, 수집 후 보상 목록 감소가 확인된 경우에만 AFK 다이아와 수령 횟수를 누적합니다.
9. AFK 다이아와 수령 횟수는 계정별 파일에 저장해 재접속 후 이어갑니다.
10. 최소 UI에 AFK 정상 작동 상태, 수령 횟수, AFK 다이아를 표시합니다.
11. 최소 UI의 현재 다이아 숫자는 보라색으로 표시합니다.
12. FPS 제한은 기본 5 FPS로 시작합니다.
13. FPS ON/OFF, 5, 15, 30, 직접 입력을 지원합니다.
14. FPS OFF는 60 FPS로 복원합니다.
15. 상단에 FPS 값을 표시합니다. 5는 초록, 15는 노랑, 30 이상은 빨강입니다.
16. 황금상자 감지와 자동 개봉은 아직 넣지 않았습니다.




V7.3 기지 복귀 안전장치 수정, 기본 FPS 15

1. 기본 FPS 제한을 15로 변경했습니다.
2. 점령 2 완료 후 기지 복귀 성공을 확인하기 전에는 AFK 이동을 시작하지 않습니다.
3. 기지 복귀 실패 시 3초 대기 후 다시 복귀를 시도합니다.
4. 기지 도착 확인 후 AFK 위치로 이동합니다.
5. 직접 클랜 서버 입장과 AFK 자동 수집 기능은 그대로 유지합니다.




V7.4 점령 중 사망 복구 및 재시도

1. 점령 1 이동 중 또는 점령 대기 중 사망하면 새 캐릭터 리스폰을 기다립니다.
2. 리스폰 후 점령 1을 처음부터 다시 진행합니다.
3. 점령 2도 같은 방식으로 사망 시 점령 2부터 다시 진행합니다.
4. 각 점령지는 지정된 점령 시간을 살아있는 상태로 끝까지 채운 경우 완료로 처리합니다.
5. 사망으로 시간이 끊기면 완료 처리하지 않고 해당 점령지를 다시 시도합니다.
6. 점령 2 완료 후에만 기지 복귀를 시작합니다.
7. 기지 복귀 성공 후에만 AFK 위치로 이동합니다.
8. V7.3에 중복으로 들어간 AFK 이동 호출을 하나로 정리했습니다.
9. 기본 FPS 15와 직접 클랜 서버 입장 기능은 그대로 유지합니다.




V7.5 FPS 적용 시점 변경

1. 스크립트 시작 시 FPS 제한을 적용하지 않습니다.
2. 일반 서버와 클랜 서버의 점령 진행 중에는 Roblox 클라이언트 기본 FPS를 그대로 사용합니다.
3. 점령 1과 점령 2 완료 후 기지 복귀까지 기본 FPS를 유지합니다.
4. 기지 복귀 후 AFK 위치로 이동하고 AFK 정상 진입이 확인된 경우에만 FPS 15 제한을 켭니다.
5. AFK 진입에 실패하면 FPS 제한은 켜지지 않습니다.
6. FPS 설정창에서 5, 15, 30, 직접 입력은 AFK 진입 후 적용할 목표값으로 저장됩니다.
7. 기본 목표값은 15 FPS입니다.




V7.6 AFK Spawn 자동 탐색 수정

1. AFK 이동 대상을 ShootForMoney 본체에서 ShootForMoney.Spawn으로 변경했습니다.
2. 현재 계정 이름으로 현재 기지를 매번 다시 찾습니다.
3. 재접속 후 기지가 바뀌어도 새 기지의 AFK Spawn을 다시 탐색합니다.
4. 점령 1, 점령 2, 기지 복귀 완료 후 AFK Spawn으로 이동합니다.
5. AFK 정상 진입이 확인된 뒤에만 기본 15 FPS 제한을 적용합니다.
6. AFK 자동 수집, AFK 다이아 누적, 수령 횟수 저장 기능은 유지합니다.




V7.7 AFK 수집 주기 및 UI 유지 수정

1. AFK 정상 진입 직후 미수령 보상을 1회 확인합니다.
2. 이후 AFK 보상 확인 주기를 30분으로 변경했습니다.
3. 보상이 있을 때만 Collect를 실행합니다.
4. AFK 보상 UI를 강제로 숨기지 않고 게임 기본 표시 상태를 유지합니다.
5. AFK 정상 진입 후 기본 15 FPS 제한을 적용합니다.
6. AFK Spawn 자동 탐색, 사망 복구, 직접 클랜 서버 입장 기능은 유지합니다.




V7.8 AFK 유휴 방지 추가

1. AFK 유휴 방지는 기본 ON입니다.
2. AFK 정상 작동 중에만 5분마다 마우스 이동 입력을 한 번 발생시킵니다.
3. 현재 마우스 위치에서 1픽셀 이동 후 원래 위치로 복귀합니다.
4. 점령, 기지 복귀, AFK 이동 중에는 유휴 방지를 실행하지 않습니다.
5. AFK를 벗어나면 유휴 방지 타이머를 초기화합니다.
6. AFK 보상은 진입 직후 1회 확인하고 이후 30분마다 확인합니다.
7. AFK 정상 진입 후 기본 15 FPS 제한을 적용합니다.




V7.9 Z키 유휴 방지, 도우미 제거, 유휴 타이머 표시

1. 자동 입장 도우미 창을 제거했습니다.
2. 자동 입장과 점령 진행 상태는 기존 작은 UI에서 확인합니다.
3. 유휴 방지는 마우스 1픽셀 이동 대신 Z키 입력 방식으로 변경했습니다.
4. AFK 정상 작동 중에만 5분마다 Z키를 짧게 눌렀다 뗍니다.
5. 작은 UI에 다음 유휴 방지까지 남은 시간을 표시합니다.
6. AFK를 벗어나면 유휴 방지 타이머를 초기화합니다.
7. AFK 보상은 진입 직후 1회, 이후 30분마다 확인합니다.
8. AFK 정상 진입 후 기본 15 FPS 제한을 유지합니다.

]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local GuiService = game:GetService("GuiService")
local VirtualUser = game:GetService("VirtualUser")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

-- AUTO EXECUTE는 로블록스가 완전히 준비되기 전에
-- 스크립트를 먼저 실행할 수 있습니다.
-- 그래서 게임과 내 계정이 준비될 때까지 기다립니다.

if not game:IsLoaded() then
	game.Loaded:Wait()
end

while not Players.LocalPlayer do
	task.wait(0.1)
end

local Player = Players.LocalPlayer

while not Player.Parent do
	task.wait(0.1)
end

local PlayerGui =
	Player:WaitForChild(
		"PlayerGui",
		30
	)

if not PlayerGui then
	return
end


-- 자동 시작 기능
local Running = true

local AUTO_PLAY = true
local AUTO_CLOSE_DAILY = true
local AUTO_BUTTON_CHECK_INTERVAL = 1

-- 클랜 자동 입장
local AUTO_CLAN_JOIN = true

-- 클랜 서버 확인 후 점령 자동 시작 요청
local ClanCaptureAutoStart = {
	Requested = false,
	Started = false
}

local ServerDisplayState = "확인중"

-- 버튼을 너무 빠르게 누르지 않도록 기다리는 시간
local CLAN_FIRST_WAIT = 5
local CLAN_STEP_WAIT = 3

-- 클랜 서버 이동 후 자동 실행될 때
-- 다시 클랜 서버 이동을 반복하지 않도록 표시를 남깁니다.
local CLAN_MARKER_FILE =
	"CaptureMini580V2_ClanTeleport_"
	.. tostring(Player.UserId)
	.. ".txt"

local function AutoSetStatus(Text)
	-- V7.9 자동 입장 도우미 창 제거
end

local function AutoSetWarning(Text)
	-- V7.9 자동 입장 도우미 창 제거
end

local function AutoHideStatusAfter(Seconds)
	-- V7.9 자동 입장 도우미 창 제거
end

local function AutoIsVisible(Object)
	if not Object
		or not Object:IsA("GuiObject") then

		return false
	end

	if not Object.Visible then
		return false
	end

	local Parent = Object.Parent

	while Parent and Parent ~= PlayerGui do
		if Parent:IsA("GuiObject")
			and not Parent.Visible then

			return false
		end

		if Parent:IsA("ScreenGui")
			and not Parent.Enabled then

			return false
		end

		Parent = Parent.Parent
	end

	return true
end

local function AutoRunButton(Button)
	if not Button then
		return false
	end

	if typeof(firesignal) == "function" then
		local Success =
			pcall(function()
				firesignal(
					Button.Activated
				)
			end)

		if Success then
			return true
		end
	end

	if typeof(getconnections) == "function" then
		local Success, Connections =
			pcall(function()
				return getconnections(
					Button.Activated
				)
			end)

		if Success and Connections then
			for _, Connection in ipairs(Connections) do
				local Function =
					Connection.Function

				if type(Function) == "function" then
					local Called =
						pcall(Function)

					if Called then
						return true
					end
				end
			end
		end
	end

	return false
end


local function AutoPhysicalClick(Button)
	if not Button
		or not Button:IsA("GuiObject") then

		return false
	end

	local Position = Button.AbsolutePosition
	local Size = Button.AbsoluteSize

	-- Roblox 화면 위쪽 여백을 실제 마우스 좌표에 더해줍니다.
	-- 이 보정이 없으면 아래쪽 버튼을 눌러야 하는데
	-- 위쪽에 있는 다른 버튼이 눌릴 수 있습니다.
	local InsetTopLeft =
		GuiService:GetGuiInset()

	local X =
		Position.X
		+ Size.X / 2
		+ InsetTopLeft.X

	local Y =
		Position.Y
		+ Size.Y / 2
		+ InsetTopLeft.Y

	local Success =
		pcall(function()
			VirtualInputManager:
				SendMouseMoveEvent(
					X,
					Y,
					game
				)

			task.wait(0.08)

			VirtualInputManager:
				SendMouseButtonEvent(
					X,
					Y,
					0,
					true,
					game,
					0
				)

			task.wait(0.1)

			VirtualInputManager:
				SendMouseButtonEvent(
					X,
					Y,
					0,
					false,
					game,
					0
				)
		end)

	return Success
end


local function WriteClanTeleportMarker()
	if typeof(writefile) ~= "function" then
		return false
	end

	return pcall(function()
		writefile(
			CLAN_MARKER_FILE,
			tostring(os.time())
		)
	end)
end

local function ReadClanTeleportMarker()
	if typeof(isfile) ~= "function"
		or typeof(readfile) ~= "function" then

		return false
	end

	local Exists = false

	pcall(function()
		Exists =
			isfile(
				CLAN_MARKER_FILE
			)
	end)

	if not Exists then
		return false
	end

	local SavedTime = nil

	pcall(function()
		SavedTime =
			tonumber(
				readfile(
					CLAN_MARKER_FILE
				)
			)
	end)

	if typeof(delfile) == "function" then
		pcall(function()
			delfile(
				CLAN_MARKER_FILE
			)
		end)
	end

	if not SavedTime then
		return false
	end

	return math.abs(
		os.time() - SavedTime
	) <= 120
end

local function DeleteClanTeleportMarker()
	if typeof(isfile) ~= "function"
		or typeof(delfile) ~= "function" then

		return
	end

	pcall(function()
		if isfile(CLAN_MARKER_FILE) then
			delfile(CLAN_MARKER_FILE)
		end
	end)
end

local function GetMyClanButton()
	local PlayingScene =
		PlayerGui:FindFirstChild(
			"PlayingScene"
		)

	local RightButtonHolder =
		PlayingScene
		and PlayingScene:FindFirstChild(
			"RightButtonHolder"
		)

	local LowerButtons2 =
		RightButtonHolder
		and RightButtonHolder:FindFirstChild(
			"LowerButtons2"
		)

	local Clan =
		LowerButtons2
		and LowerButtons2:FindFirstChild(
			"Clan"
		)

	if Clan
		and Clan:IsA("GuiButton") then

		return Clan
	end

	return nil
end

local function GetCreateClanButton()
	local ClanUI =
		PlayerGui:FindFirstChild(
			"ClanUI"
		)

	local Frame =
		ClanUI
		and ClanUI:FindFirstChild(
			"Frame"
		)

	local Pages =
		Frame
		and Frame:FindFirstChild(
			"Pages"
		)

	local Join =
		Pages
		and Pages:FindFirstChild(
			"Join"
		)

	local Inner =
		Join
		and Join:FindFirstChild(
			"ClanUI"
		)

	local Create =
		Inner
		and Inner:FindFirstChild(
			"Create"
		)

	if Create
		and Create:IsA("GuiButton") then

		return Create
	end

	return nil
end

local function GetClanSeasonButton()
	local ClanUI =
		PlayerGui:FindFirstChild(
			"ClanUI"
		)

	local Frame =
		ClanUI
		and ClanUI:FindFirstChild(
			"Frame"
		)

	local NavigationFrame =
		Frame
		and Frame:FindFirstChild(
			"NavigationFrame"
		)

	local Season =
		NavigationFrame
		and NavigationFrame:FindFirstChild(
			"Season"
		)

	local Button =
		Season
		and Season:FindFirstChild(
			"TextButton"
		)

	if Button
		and Button:IsA("GuiButton") then

		return Button
	end

	return nil
end

local function IsClanSeasonPageOpen()
	local ClanUI = PlayerGui:FindFirstChild("ClanUI")
	local Frame = ClanUI and ClanUI:FindFirstChild("Frame")
	local Pages = Frame and Frame:FindFirstChild("Pages")
	local BossHuntPage = Pages and Pages:FindFirstChild("BossHunt")

	return BossHuntPage
		and BossHuntPage:IsA("GuiObject")
		and AutoIsVisible(BossHuntPage)
end

local function CloseClanWindow()
	local ClanUI = PlayerGui:FindFirstChild("ClanUI")
	local Frame = ClanUI and ClanUI:FindFirstChild("Frame")
	local Close = Frame and Frame:FindFirstChild("Close")

	if Close
		and Close:IsA("GuiButton")
		and AutoIsVisible(Close) then
		return AutoPhysicalClick(Close)
	end

	return false
end


local function GetClanServerButton()
	local ClanUI =
		PlayerGui:FindFirstChild(
			"ClanUI"
		)

	local Frame =
		ClanUI
		and ClanUI:FindFirstChild(
			"Frame"
		)

	local Pages =
		Frame
		and Frame:FindFirstChild(
			"Pages"
		)

	local BossHuntPage =
		Pages
		and Pages:FindFirstChild(
			"BossHunt"
		)

	local BossHunt =
		BossHuntPage
		and BossHuntPage:FindFirstChild(
			"BossHunt"
		)

	local BossProgress =
		BossHunt
		and BossHunt:FindFirstChild(
			"BossProgress"
		)

	local BossQuest =
		BossProgress
		and BossProgress:FindFirstChild(
			"BossQuest"
		)

	if BossQuest
		and BossQuest:IsA("GuiButton") then

		return BossQuest
	end

	return nil
end

local function WaitForVisibleButton(
	Getter,
	Timeout
)
	local EndTime =
		os.clock() + Timeout

	while Running
		and os.clock() < EndTime do

		local Button =
			Getter()

		if Button
			and AutoIsVisible(Button) then

			return Button
		end

		task.wait(0.25)
	end

	return nil
end

local function WaitForPlayingScreen()
	local EndTime =
		os.clock() + 30

	while Running
		and os.clock() < EndTime do

		local PlayingScene =
			PlayerGui:FindFirstChild(
				"PlayingScene"
			)

		local PlayScene =
			PlayerGui:FindFirstChild(
				"PlayScene"
			)

		local PlayFrame =
			PlayScene
			and PlayScene:FindFirstChild(
				"Frame"
			)

		local Play =
			PlayFrame
			and PlayFrame:FindFirstChild(
				"Play"
			)

		local PlayVisible =
			Play
			and Play:IsA("GuiObject")
			and AutoIsVisible(Play)

		if PlayingScene
			and not PlayVisible then

			return true
		end

		task.wait(0.25)
	end

	return false
end

local function GetPlayButton()
	local PlayScene =
		PlayerGui:FindFirstChild("PlayScene")

	local Frame =
		PlayScene
		and PlayScene:FindFirstChild("Frame")

	local Play =
		Frame
		and Frame:FindFirstChild("Play")

	if Play
		and Play:IsA("GuiButton") then

		return Play
	end

	return nil
end

local function GetDailyCollectButton()
	local DailyLogin =
		PlayerGui:FindFirstChild("DailyLogin")

	local Frame =
		DailyLogin
		and DailyLogin:FindFirstChild("Frame")

	if not Frame then
		return nil
	end

	local Collect =
		Frame:FindFirstChild("Collect")

	if Collect
		and Collect:IsA("GuiButton") then

		return Collect
	end

	return nil
end


local function GetDailyCloseButton()
	local DailyLogin =
		PlayerGui:FindFirstChild("DailyLogin")

	local Frame =
		DailyLogin
		and DailyLogin:FindFirstChild("Frame")

	if not Frame then
		return nil
	end

	-- 작은 X 닫기 버튼을 우선 사용합니다.
	local Close =
		Frame:FindFirstChild("Close")

	if Close
		and Close:IsA("GuiButton") then

		return Close
	end

	return nil
end

local LastPlayClick = 0
local LastDailyClick = 0
local AutoButtonRunning = true

-- 같은 스크립트를 다시 실행했을 때
-- 이전 자동 감시가 같이 남지 않도록 구분합니다.
local AutoSessionId = nil

if typeof(getgenv) == "function" then
	local Env = getgenv()

	Env.CaptureMiniAutoSession =
		(Env.CaptureMiniAutoSession or 0) + 1

	AutoSessionId =
		Env.CaptureMiniAutoSession
end

local function IsAutoSessionCurrent()
	if not AutoButtonRunning then
		return false
	end

	if AutoSessionId == nil
		or typeof(getgenv) ~= "function" then

		return true
	end

	return getgenv().CaptureMiniAutoSession
		== AutoSessionId
end

local function HandlePlay()
	if not AUTO_PLAY then
		return
	end

	local Button =
		GetPlayButton()

	if not Button
		or not AutoIsVisible(Button) then

		return
	end

	if os.clock() - LastPlayClick < 1 then
		return
	end

	LastPlayClick = os.clock()

	AutoSetStatus(
		"게임 시작 버튼이 보여서 자동으로 누르는 중입니다."
	)

	AutoRunButton(Button)
end

local function HandleDaily()
	if not AUTO_CLOSE_DAILY then
		return
	end

	local CollectButton =
		GetDailyCollectButton()

	if CollectButton
		and AutoIsVisible(CollectButton) then

		if os.clock() - LastDailyClick < 2 then
			return
		end

		LastDailyClick = os.clock()

		AutoSetStatus(
			"일일 보상 수령 가능\nCOLLECT 버튼을 누르는 중입니다."
		)

		local Success =
			AutoPhysicalClick(
				CollectButton
			)

		if not Success then
			Success =
				AutoRunButton(
					CollectButton
				)
		end

		if Success then
			task.wait(1.5)
		end

		return
	end

	local CloseButton =
		GetDailyCloseButton()

	if not CloseButton
		or not AutoIsVisible(CloseButton) then

		return
	end

	if os.clock() - LastDailyClick < 2 then
		return
	end

	LastDailyClick = os.clock()

	AutoSetStatus(
		"일일 보상 수령 완료\nX 닫기 버튼을 누르는 중입니다."
	)

	local Success =
		AutoPhysicalClick(
			CloseButton
		)

	if not Success then
		AutoRunButton(
			CloseButton
		)
	end
end

task.spawn(function()
	while IsAutoSessionCurrent() do
		HandlePlay()
		HandleDaily()

		task.wait(
			AUTO_BUTTON_CHECK_INTERVAL
		)
	end
end)


-- V7.1
-- AUTO EXECUTE 시 Knit와 클랜 데이터가 아직 준비되지 않은 경우가 있어서
-- 실제 게임 컨트롤러가 준비될 때까지 기다린 뒤 Join을 호출합니다.
local ClanDirect = {
	Ready = false,
	IsClanServer = false,
	JoinRequested = false,
	Error = nil,
	Attempts = 0
}

local function LoadClanDirectModules()
	local EndTime = os.clock() + 45

	while Running and os.clock() < EndTime do
		local Success, Result =
			pcall(function()
				local Knit =
					require(
						ReplicatedStorage
							:WaitForChild("Packages")
							:WaitForChild("Knit")
					)

				local PlaceUtil =
					require(
						ReplicatedStorage
							:WaitForChild("Shared")
							:WaitForChild("Util")
							:WaitForChild("PlaceUtil")
					)

				local ClanServerService =
					Knit.GetService(
						"ClanServerService"
					)

				if not ClanServerService then
					error("ClanServerService 없음")
				end

				return {
					Knit = Knit,
					PlaceUtil = PlaceUtil,
					ClanServerService = ClanServerService
				}
			end)

		if Success and Result then
			ClanDirect.Ready = true
			return Result
		end

		ClanDirect.Error = tostring(Result)
		task.wait(1)
	end

	return nil
end

local function WaitForClanData()
	local EndTime = os.clock() + 30

	while Running and os.clock() < EndTime do
		local FactionId =
			Player:GetAttribute("FactionId")

		local FactionRank =
			Player:GetAttribute("FactionRank")

		if FactionId
			and (FactionRank or 0) >= 1 then

			return true
		end

		task.wait(1)
	end

	return false
end

local function DirectIsClanServer(Modules)
	local Success, Result =
		pcall(function()
			return Modules.PlaceUtil.isClanServer()
		end)

	if not Success then
		ClanDirect.Error = tostring(Result)
		return nil
	end

	return Result == true
end

local function DirectJoinClanServer(Modules)
	if ClanDirect.JoinRequested then
		return false
	end

	ClanDirect.Attempts =
		ClanDirect.Attempts + 1

	ClanDirect.JoinRequested = true

	local Success, Result =
		pcall(function()
			return Modules.ClanServerService:Join()
		end)

	if not Success then
		ClanDirect.Error = tostring(Result)
		ClanDirect.JoinRequested = false
		return false
	end

	return true
end

task.spawn(function()
	if not AUTO_CLAN_JOIN then
		AutoSetStatus(
			"상태: 완료\n클랜 자동 입장 기능이 꺼져 있습니다."
		)
		AutoHideStatusAfter(4)
		return
	end

	AutoSetStatus(
		"상태: 진행 중"
		.. "\n현재 단계: Knit 준비 대기"
		.. "\n서버 상태: 확인 중"
	)

	local Modules =
		LoadClanDirectModules()

	if not Modules then
		AutoSetWarning(
			"ClanServerService 준비 실패"
			.. "\n\n계정: "
			.. Player.Name
			.. "\n"
			.. tostring(
				ClanDirect.Error
			)
		)
		return
	end

	local IsClan =
		DirectIsClanServer(Modules)

	if IsClan == true then
		ClanDirect.IsClanServer = true
		ServerDisplayState = "클랜서버"
		ClanCaptureAutoStart.Requested = true

		AutoSetStatus(
			"상태: 완료"
			.. "\n서버 상태: 클랜 서버"
			.. "\nJoin 호출 안 함"
			.. "\n점령 자동 시작 준비"
		)

		AutoHideStatusAfter(7)
		return
	end

	ServerDisplayState = "일반서버"

	AutoSetStatus(
		"상태: 진행 중"
		.. "\n서버 상태: 일반 서버"
		.. "\nPLAY 화면 준비 대기"
	)

	WaitForPlayingScreen()

	AutoSetStatus(
		"상태: 진행 중"
		.. "\n서버 상태: 일반 서버"
		.. "\n클랜 데이터 준비 대기"
	)

	local HasClan =
		WaitForClanData()

	if not HasClan then
		AutoSetWarning(
			"클랜 데이터 확인 실패"
			.. "\nFactionId 또는 FactionRank 없음"
		)
		return
	end

	-- 일일보상 자동 수령이 처리될 시간을 줍니다.
	task.wait(5)

	local Recheck =
		DirectIsClanServer(Modules)

	if Recheck == true then
		ClanDirect.IsClanServer = true
		ServerDisplayState = "클랜서버"
		ClanCaptureAutoStart.Requested = true
		return
	end

	for Attempt = 1, 3 do
		if not Running then
			return
		end

		AutoSetStatus(
			"상태: 진행 중"
			.. "\n서버 상태: 일반 서버"
			.. "\n클랜 서버 직접 이동 "
			.. tostring(Attempt)
			.. "/3"
		)

		ClanDirect.JoinRequested = false

		if DirectJoinClanServer(Modules) then
			AutoSetStatus(
				"상태: 이동 요청 완료"
				.. "\nClanServerService:Join() 호출 완료"
				.. "\n서버 이동 대기"
			)

			-- 실제 Teleport가 시작될 시간을 충분히 기다립니다.
			task.wait(12)

			-- 12초 뒤에도 같은 일반 서버라면 다시 시도합니다.
			local StillClan =
				DirectIsClanServer(Modules)

			if StillClan == true then
				return
			end
		else
			AutoSetStatus(
				"Join 호출 실패"
				.. "\n"
				.. tostring(
					ClanDirect.Error
				)
			)

			task.wait(3)
		end
	end

	AutoSetWarning(
		"클랜 서버 직접 이동 실패"
		.. "\n\n계정: "
		.. Player.Name
		.. "\nJoin 3회 시도 완료"
		.. "\n오류: "
		.. tostring(
			ClanDirect.Error
		)
	)
end)

-- V8.0 구조 정리: 설정값을 하나의 테이블로 묶어 최상위 local 사용을 줄입니다.
local Settings = {}

Settings.GUI_NAME = "ShowTimeIntegratedFarmV10Test"

Settings.POINT_1 = CFrame.new(776.2, -13.6, 748.1)
Settings.POINT_2 = CFrame.new(11.1, 664.3, 11.1)

Settings.POINT1_WAIT_TIME = 65
Settings.POINT2_WAIT_TIME = 95

-- 점령지 이동 속도
-- 처음 기본값은 300입니다.
-- 설정 팝업에서 사용자가 원하는 기본값으로 저장할 수 있습니다.
Settings.MOVE_SPEED_MIN = 10
Settings.MOVE_SPEED_MAX = 500
Settings.MOVE_SPEED_DEFAULT_FILE = "CaptureMini580V2_MoveSpeed.txt"

local function LoadMoveSpeedDefault()
	local DefaultValue = 300

	if typeof(isfile) == "function"
		and typeof(readfile) == "function" then

		local Success, Exists =
			pcall(function()
				return isfile(
					Settings.MOVE_SPEED_DEFAULT_FILE
				)
			end)

		if Success and Exists then
			local ReadSuccess, SavedText =
				pcall(function()
					return readfile(
						Settings.MOVE_SPEED_DEFAULT_FILE
					)
				end)

			if ReadSuccess then
				local SavedValue =
					tonumber(SavedText)

				if SavedValue then
					DefaultValue =
						math.clamp(
							math.floor(
								SavedValue
							),
							Settings.MOVE_SPEED_MIN,
							Settings.MOVE_SPEED_MAX
						)
				end
			end
		end
	end

	return DefaultValue
end

local CAPTURE_MOVE_DEFAULT =
	LoadMoveSpeedDefault()

local CAPTURE_MOVE_SPEED =
	CAPTURE_MOVE_DEFAULT

Settings.SPIN_RETRY_COUNT = 2
Settings.SPIN_RETRY_DELAY = 5

Settings.SPIN_TIMER_WAIT = 6
Settings.SPIN_TIMER_FAIL_RECHECK = 60
Settings.SPIN_UI_MISSING_RECHECK = 300

Settings.RETURN_DIAMOND_REFRESH_DELAY = 3

-- Running은 위 자동 기능 시작 전에 선언됨

-- V8.0 구조 정리: 실행 중 바뀌는 상태값을 하나의 테이블로 묶습니다.
local RuntimeState = {}

local IntegratedBridge = getgenv and getgenv().ShowTimeIntegratedBridge or {}
if getgenv then
	getgenv().ShowTimeIntegratedBridge = IntegratedBridge
end

RuntimeState.Working = false
RuntimeState.CaptureMoving = false
RuntimeState.GuiVisible = true

RuntimeState.AFKEnabled = true
RuntimeState.RenderingEnabled = true
RuntimeState.AutoReturnBase = true
RuntimeState.AutoSpinEnabled = true
RuntimeState.GameUIVisible = true
RuntimeState.AutoGameUIOff60 = true

RuntimeState.SpinBusy = false
RuntimeState.ScriptStartTime = os.clock()

RuntimeState.StateText = "대기"
RuntimeState.RemainingTime = 0
RuntimeState.IdleStart = nil

local Revenue = {
	StartTime = nil,
	StartDiamonds = nil
}

RuntimeState.AFKCount = 0
RuntimeState.LastAFKTime = "없음"

local FARM_RECOVERY_FILE = "showtime_farm_recovery_v30_" .. tostring(Player.UserId) .. ".json"
RuntimeState.FarmRecovery = nil
RuntimeState.FarmRecoveryPending = false
RuntimeState.FarmRecoveryStatus = "복구기록: 확인 전"

local function SaveFarmRecovery(Data)
	if type(writefile) ~= "function" or type(Data) ~= "table" then return false end
	Data.Version, Data.UserId, Data.Pending, Data.UpdatedAt = 30, Player.UserId, true, os.time()
	local Ok = pcall(function()
		writefile(FARM_RECOVERY_FILE, HttpService:JSONEncode(Data))
		if type(readfile) ~= "function" or type(isfile) ~= "function" or not isfile(FARM_RECOVERY_FILE) then
			error("저장된 복구 파일을 다시 찾지 못했습니다")
		end
		local Verified = HttpService:JSONDecode(readfile(FARM_RECOVERY_FILE))
		if type(Verified) ~= "table" or Verified.Pending ~= true
		or tostring(Verified.VehicleUUID or "") ~= tostring(Data.VehicleUUID or "") then
			error("복구 파일 재검증 내용이 일치하지 않습니다")
		end
	end)
	if Ok then
		RuntimeState.FarmRecovery, RuntimeState.FarmRecoveryPending = Data, true
		RuntimeState.FarmRecoveryStatus = "복구기록: 저장 확인 완료"
	else
		RuntimeState.FarmRecoveryStatus = "복구기록: 저장 검증 실패"
	end
	RuntimeState.FarmRecoverySaveVerified = Ok
	return Ok
end

local function ClearFarmRecovery()
	RuntimeState.FarmRecoveryPending, RuntimeState.FarmRecovery = false, nil
	RuntimeState.FarmRecoveryStatus = "복구기록: 사용자 정지로 해제"
	if type(writefile) == "function" then
		pcall(function()
			writefile(FARM_RECOVERY_FILE, HttpService:JSONEncode({Version=30, UserId=Player.UserId, Pending=false, UpdatedAt=os.time()}))
		end)
	end
end

local function LoadFarmRecovery()
	if type(readfile) ~= "function" or type(isfile) ~= "function" then
		RuntimeState.FarmRecoveryStatus = "복구기록: 실행기 읽기 기능 없음"
		return
	end
	local ExistsOk, Exists = pcall(isfile, FARM_RECOVERY_FILE)
	if not ExistsOk then
		RuntimeState.FarmRecoveryStatus = "복구기록: 파일 확인 오류"
		return
	end
	if not Exists then
		RuntimeState.FarmRecoveryStatus = "복구기록: 파일 없음"
		return
	end
	local Ok, Data = pcall(function() return HttpService:JSONDecode(readfile(FARM_RECOVERY_FILE)) end)
	if Ok and type(Data) == "table" and Data.Pending == true and tonumber(Data.UserId) == Player.UserId then
		RuntimeState.FarmRecovery, RuntimeState.FarmRecoveryPending = Data, true
		RuntimeState.FarmRecoveryStatus = "복구기록: 발견 · 점령 후 재개"
		RuntimeState.StateText = "이전 자동팜 비정상 종료 감지 · 점령 후 복구"
	elseif not Ok or type(Data) ~= "table" then
		RuntimeState.FarmRecoveryStatus = "복구기록: 파일 읽기 오류"
	elseif Data.Pending ~= true then
		RuntimeState.FarmRecoveryStatus = "복구기록: 정상 종료 기록"
	else
		RuntimeState.FarmRecoveryStatus = "복구기록: 계정 불일치"
	end
end

LoadFarmRecovery()

RuntimeState.AFKRewardState = {
	CollectCount = 0,
	Diamonds = 0,
	Status = "AFK 이동 대기",
	Busy = false,
	LastCollect = "없음"
}

local AFK_STATS_FILE =
	"CaptureMini580V2_AFKStats_"
	.. tostring(Player.UserId)
	.. ".json"

Settings.FPS_CAP = 15
local FPS_ENABLED = false

Settings.AFK_COLLECT_INTERVAL = 30 * 60
RuntimeState.AFKNextCollectAt = nil
RuntimeState.AFKInitialCollectDone = false

Settings.AFK_IDLE_PREVENT_ENABLED = true -- 상시 자리비움 방지 기본값: 켜짐
Settings.AFK_IDLE_PREVENT_INTERVAL = 5 * 60
RuntimeState.AFKNextIdleInputAt = nil

local function LoadAFKStats()
	if typeof(isfile) ~= "function"
		or typeof(readfile) ~= "function" then
		return
	end

	local Success, Exists = pcall(function()
		return isfile(AFK_STATS_FILE)
	end)

	if not Success or not Exists then
		return
	end

	pcall(function()
		local Decoded =
			HttpService:JSONDecode(
				readfile(AFK_STATS_FILE)
			)

		if type(Decoded) == "table" then
			RuntimeState.AFKRewardState.CollectCount =
				tonumber(Decoded.CollectCount) or 0

			RuntimeState.AFKRewardState.Diamonds =
				tonumber(Decoded.Diamonds) or 0
		end
	end)
end

local function SaveAFKStats()
	if typeof(writefile) ~= "function" then
		return
	end

	pcall(function()
		writefile(
			AFK_STATS_FILE,
			HttpService:JSONEncode({
				CollectCount = RuntimeState.AFKRewardState.CollectCount,
				Diamonds = RuntimeState.AFKRewardState.Diamonds
			})
		)
	end)
end

local function SetFPSLimitEnabled(State)
	FPS_ENABLED = State == true

	if typeof(setfpscap) ~= "function" then
		return
	end

	pcall(function()
		if FPS_ENABLED then
			setfpscap(Settings.FPS_CAP)
		else
			setfpscap(60)
		end
	end)
end

local function ApplyFPSCap(Value)
	Value =
		math.clamp(
			math.floor(
				tonumber(Value) or 5
			),
			1,
			240
		)

	Settings.FPS_CAP = Value

	if FPS_ENABLED
		and typeof(setfpscap) == "function" then

		pcall(function()
			setfpscap(Settings.FPS_CAP)
		end)
	end
end

LoadAFKStats()

RuntimeState.BasePoint = nil
RuntimeState.BaseSaved = false

RuntimeState.StartDiamonds = nil
RuntimeState.CurrentDiamonds = nil
RuntimeState.DiamondProfit = 0

-- 게임 로딩 직후 다이아 전광판이 잠깐 다른 숫자를 표시할 수 있습니다.
-- 같은 값이 여러 번 연속 확인된 뒤에만 시작 다이아로 인정합니다.
RuntimeState.DiamondStartCandidate = nil
RuntimeState.DiamondStartCandidateCount = 0
Settings.DIAMOND_START_CONFIRM_COUNT = 6
RuntimeState.DiamondStatus = "탐지 중"
RuntimeState.DiamondLabel = nil

RuntimeState.LastDiamondValue = nil
RuntimeState.LastDiamondChange = 0
RuntimeState.LastDiamondChangeTime = "없음"

RuntimeState.SpinCount = 0
RuntimeState.RewardCount = 0
RuntimeState.LastSpinTime = "없음"
RuntimeState.SpinStatus = "자동 확인 대기"
RuntimeState.NextSpinAt = nil

local Connections = {}
local HiddenGuiStates = {}

local function AddConnection(Connection)
	table.insert(Connections, Connection)
	return Connection
end

local function GetRoot()
	local Character = Player.Character

	if not Character then
		return nil
	end

	return Character:FindFirstChild("HumanoidRootPart")
end

local function FormatTime(Value)
	Value = math.max(0, math.floor(Value or 0))

	local H = math.floor(Value / 3600)
	local M = math.floor((Value % 3600) / 60)
	local S = Value % 60

	return string.format("%02d:%02d:%02d", H, M, S)
end

local function FormatDuration(Value)
	Value = math.max(0, math.floor(Value or 0))

	local Days = math.floor(Value / 86400)
	local Hours = math.floor((Value % 86400) / 3600)
	local Minutes = math.floor((Value % 3600) / 60)

	if Days > 0 then
		return tostring(Days)
			.. "일 "
			.. tostring(Hours)
			.. "시간 "
			.. tostring(Minutes)
			.. "분"
	end

	if Hours > 0 then
		return tostring(Hours)
			.. "시간 "
			.. tostring(Minutes)
			.. "분"
	end

	return tostring(Minutes) .. "분"
end

local function FormatCountdown(Value)
	Value = math.max(0, math.floor(Value or 0))

	local Hours = math.floor(Value / 3600)
	local Minutes = math.floor((Value % 3600) / 60)
	local Seconds = Value % 60

	if Hours > 0 then
		return tostring(Hours)
			.. "시간 "
			.. tostring(Minutes)
			.. "분 "
			.. tostring(Seconds)
			.. "초"
	end

	if Minutes > 0 then
		return tostring(Minutes)
			.. "분 "
			.. tostring(Seconds)
			.. "초"
	end

	return tostring(Seconds) .. "초"
end


local function FormatNumber(Value)
	if Value == nil then
		return "탐지 중"
	end

	Value = math.floor(Value)

	local Sign = ""

	if Value < 0 then
		Sign = "-"
		Value = math.abs(Value)
	end

	local Text = tostring(Value)

	while true do
		local NewText, Count = Text:gsub(
			"^(%d+)(%d%d%d)",
			"%1,%2"
		)

		Text = NewText

		if Count == 0 then
			break
		end
	end

	return Sign .. Text
end

local function FormatSignedNumber(Value)
	if Value == nil then
		return "없음"
	end

	if Value > 0 then
		return "+" .. FormatNumber(Value)
	end

	return FormatNumber(Value)
end

local function ParseNumber(Text)
	if type(Text) ~= "string" then
		return nil
	end

	local Clean = Text
		:gsub("<.->", "")
		:gsub(",", "")

	local NumberText = Clean:match("%d+")

	if not NumberText then
		return nil
	end

	return tonumber(NumberText)
end

local function ParseSpinTimer(Text)
	if type(Text) ~= "string" then
		return nil
	end

	local H, M, S = Text:match(
		"(%d+):(%d+):(%d+)"
	)

	if H and M and S then
		return tonumber(H) * 3600
			+ tonumber(M) * 60
			+ tonumber(S)
	end

	local M2, S2 = Text:match(
		"(%d+):(%d+)"
	)

	if M2 and S2 then
		return tonumber(M2) * 60
			+ tonumber(S2)
	end

	return nil
end

local function IsVisible(Object)
	if not Object then
		return false
	end

	if not Object:IsA("GuiObject") then
		return false
	end

	if not Object.Visible then
		return false
	end

	local Parent = Object.Parent

	while Parent and Parent ~= PlayerGui do
		if Parent:IsA("GuiObject")
			and not Parent.Visible then

			return false
		end

		if Parent:IsA("ScreenGui")
			and not Parent.Enabled then

			return false
		end

		Parent = Parent.Parent
	end

	return true
end

local function FireButton(ButtonObject)
	if not ButtonObject then
		return false
	end

	if typeof(firesignal) ~= "function" then
		return false
	end

	return pcall(function()
		firesignal(ButtonObject.Activated)
	end)
end

local function SaveBasePoint()
	local Root = GetRoot()

	if not Root then
		RuntimeState.BaseSaved = false
		return false
	end

	RuntimeState.BasePoint = Root.CFrame
	RuntimeState.BaseSaved = true

	return true
end

local function Teleport(Target)
	local Character = Player.Character
	local Root = GetRoot()

	if not Character
		or not Root
		or not Target then

		return false
	end

	Root.AssemblyLinearVelocity = Vector3.zero
	Root.AssemblyAngularVelocity = Vector3.zero

	return pcall(function()
		Character:PivotTo(Target)
	end)
end

local function StopCaptureMovement()
	RuntimeState.CaptureMoving = false

	local Root = GetRoot()
	local Character = Player.Character

	if Root then
		Root.AssemblyLinearVelocity = Vector3.zero
		Root.AssemblyAngularVelocity = Vector3.zero
	end

	if Character then
		local Humanoid =
			Character:FindFirstChildOfClass("Humanoid")

		if Humanoid then
			Humanoid:Move(
				Vector3.zero,
				false
			)
		end
	end
end

local function FlyToCapturePoint(
	Target,
	Speed,
	CancelWhenWorkStops
)
	local Character = Player.Character
	local Root = GetRoot()

	if not Character
		or not Root
		or not Target then

		return false
	end

	local Humanoid =
		Character:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return false
	end

	Speed = tonumber(Speed)
		or CAPTURE_MOVE_SPEED

	if Speed <= 0 then
		return false
	end

	local CollisionStates = {}
	local OldAutoRotate = Humanoid.AutoRotate

	for _, Object in ipairs(Character:GetDescendants()) do
		if Object:IsA("BasePart") then
			CollisionStates[Object] =
				Object.CanCollide

			Object.CanCollide = false
		end
	end

	RuntimeState.CaptureMoving = true
	Humanoid.AutoRotate = true

	local Completed = false

	local Success =
		pcall(function()
			while Running
				and RuntimeState.CaptureMoving do

				if CancelWhenWorkStops
					and not RuntimeState.Working then

					break
				end

				Character = Player.Character
				Root = GetRoot()

				if not Character
					or not Root then

					break
				end

				Humanoid =
					Character:FindFirstChildOfClass(
						"Humanoid"
					)

				if not Humanoid then
					break
				end

				local Offset =
					Target.Position
					- Root.Position

				local Distance =
					Offset.Magnitude

				if Distance <= 2 then
					Root.AssemblyLinearVelocity =
						Vector3.zero

					Character:PivotTo(Target)

					Humanoid:Move(
						Vector3.zero,
						false
					)

					Completed = true
					break
				end

				local Direction =
					Offset.Unit

				-- 게임이 이동 중 충돌을 다시 켜는 경우가 있어서
				-- 매 순간 다시 충돌을 꺼줍니다.
				for _, Object in ipairs(Character:GetDescendants()) do
					if Object:IsA("BasePart") then
						Object.CanCollide = false
					end
				end

				-- 걷는 동작을 계속 유지합니다.
				Humanoid:Move(
					Vector3.new(
						Direction.X,
						0,
						Direction.Z
					),
					false
				)

				-- 실제 이동은 속도 150으로 날아갑니다.
				-- 캐릭터를 고정하지 않아서
				-- 도착 후 원위치로 되돌아가는 현상을 줄입니다.
				local ActiveSpeed =
					math.clamp(
						tonumber(
							CAPTURE_MOVE_SPEED
						) or Speed,
						Settings.MOVE_SPEED_MIN,
						Settings.MOVE_SPEED_MAX
					)

				Root.AssemblyLinearVelocity =
					Direction * ActiveSpeed

				Root.AssemblyAngularVelocity =
					Vector3.zero

				RunService.Heartbeat:Wait()
			end
		end)

	StopCaptureMovement()

	Humanoid =
		Character
		and Character:FindFirstChildOfClass(
			"Humanoid"
		)

	if Humanoid then
		Humanoid.AutoRotate =
			OldAutoRotate
	end

	for Object, OldState in pairs(CollisionStates) do
		if Object and Object.Parent then
			pcall(function()
				Object.CanCollide = OldState
			end)
		end
	end

	if not Success then
		return false
	end

	return Completed
end


local function SetRendering(State)
	RuntimeState.RenderingEnabled = State

	pcall(function()
		RunService:Set3dRenderingEnabled(State)
	end)
end

local function SetCoreUI(State)
	pcall(function()
		StarterGui:SetCoreGuiEnabled(
			Enum.CoreGuiType.All,
			State
		)
	end)

	pcall(function()
		StarterGui:SetCore(
			"TopbarEnabled",
			State
		)
	end)
end

local function HideOneGameGui(Object)
	if not Object:IsA("ScreenGui") then
		return
	end

	if Object.Name == Settings.GUI_NAME
		or Object.Name == "VehiclePickerSpawnAttackV24"
		or Object.Name == "ShowTimeAutoFarmV13" then
		return
	end

	if HiddenGuiStates[Object] == nil then
		HiddenGuiStates[Object] = Object.Enabled
	end

	Object.Enabled = false
end

local function SetGameUIVisible(State)
	RuntimeState.GameUIVisible = State

	if State then
		SetCoreUI(true)

		for Object, OldState in pairs(HiddenGuiStates) do
			if Object and Object.Parent then
				pcall(function()
					Object.Enabled = OldState
				end)
			end
		end

		table.clear(HiddenGuiStates)
	else
		SetCoreUI(false)

		for _, Object in ipairs(PlayerGui:GetChildren()) do
			HideOneGameGui(Object)
		end
	end
end

local function WaitCancelable(Seconds)
	local EndTime = os.clock() + Seconds

	while Running and RuntimeState.Working do
		local Left = EndTime - os.clock()

		if Left <= 0 then
			break
		end

		RuntimeState.RemainingTime = math.ceil(Left)

		task.wait(0.1)
	end

	RuntimeState.RemainingTime = 0

	return RuntimeState.Working
end

local function FindDiamondLabel()
	local PlayerTycoons = workspace:FindFirstChild("PlayerTycoons")

	if not PlayerTycoons then
		return nil
	end

	local Tycoon = PlayerTycoons:FindFirstChild(Player.Name)

	if not Tycoon then
		return nil
	end

	local Models = Tycoon:FindFirstChild("Models")

	if not Models then
		return nil
	end

	local Miner = Models:FindFirstChild("DiamondMiner")

	if not Miner then
		return nil
	end

	local Storage = Miner:FindFirstChild("Storage")

	if not Storage then
		return nil
	end

	local Surface = Storage:FindFirstChild("SurfaceGui")

	if not Surface then
		return nil
	end

	local Frame = Surface:FindFirstChild("Frame")

	if not Frame then
		return nil
	end

	local DiamondStorage = Frame:FindFirstChild("DiamondStorage")

	if not DiamondStorage then
		return nil
	end

	local Inner = DiamondStorage:FindFirstChild("Frame")

	if not Inner then
		return nil
	end

	local LabelObject = Inner:FindFirstChild("TextLabel")

	if LabelObject
		and LabelObject:IsA("TextLabel") then

		return LabelObject
	end

	return nil
end

local function GetAFKShootPart()
	local PlayerTycoons =
		workspace:FindFirstChild("PlayerTycoons")

	local Tycoon =
		PlayerTycoons
		and PlayerTycoons:FindFirstChild(Player.Name)

	local Models =
		Tycoon
		and Tycoon:FindFirstChild("Models")

	local AfkShooting =
		Models
		and Models:FindFirstChild("AfkShooting")

	local ManualWorker =
		AfkShooting
		and AfkShooting:FindFirstChild("ManualWorker")

	local ShootForMoney =
		ManualWorker
		and ManualWorker:FindFirstChild("ShootForMoney")

	local Spawn =
		ShootForMoney
		and ShootForMoney:FindFirstChild("Spawn")

	if Spawn
		and Spawn:IsA("BasePart") then

		return Spawn
	end

	return nil
end

local function GetAFKCollectButton()
	local Scene =
		PlayerGui:FindFirstChild("AFKScene")

	if not Scene then
		return nil
	end

	for _, Object in ipairs(
		Scene:GetDescendants()
	) do
		if Object:IsA("GuiButton")
			and string.lower(
				tostring(Object.Name)
			) == "collect" then

			return Object
		end
	end

	return nil
end

local AFKDataController = nil

local function GetAFKDataController()
	if AFKDataController then
		return AFKDataController
	end

	local Packages =
		ReplicatedStorage:FindFirstChild("Packages")

	local KnitModule =
		Packages
		and Packages:FindFirstChild("Knit")

	if not KnitModule then
		return nil
	end

	local Success, Knit =
		pcall(
			require,
			KnitModule
		)

	if not Success
		or not Knit then

		return nil
	end

	local ControllerSuccess, Controller =
		pcall(function()
			return Knit.GetController(
				"DataController"
			)
		end)

	if ControllerSuccess then
		AFKDataController = Controller
	end

	return AFKDataController
end

local function GetAFKRewards()
	local Controller =
		GetAFKDataController()

	if not Controller then
		return nil
	end

	local Success, Rewards =
		pcall(function()
			return Controller:Get(
				"AFKShootingRewards"
			) or {}
		end)

	if Success
		and type(Rewards) == "table" then

		return Rewards
	end

	return nil
end

local function CountAFKRewards(Rewards)
	local Count = 0
	local Diamonds = 0

	if type(Rewards) ~= "table" then
		return Count, Diamonds
	end

	for _, Reward in pairs(Rewards) do
		if type(Reward) == "table" then
			Count = Count + 1

			local RewardName =
				tostring(
					Reward[1] or ""
				)

			local RewardValue =
				tonumber(
					Reward[2]
				) or 0

			if string.lower(RewardName)
				== "diamonds" then

				Diamonds =
					Diamonds + RewardValue
			end
		end
	end

	return Count, Diamonds
end

local function IsAFKActive()
	return
		Player:GetAttribute("AFK_TICKET") ~= nil
		and PlayerGui:FindFirstChild("AFKScene") ~= nil
end

local function MoveToAFK()
	if not RuntimeState.AFKEnabled then
		RuntimeState.AFKRewardState.Status = "AFK 꺼짐"
		return false
	end

	local Part =
		GetAFKShootPart()

	if not Part then
		RuntimeState.AFKRewardState.Status =
			"AFK 위치 못 찾음"

		return false
	end

	RuntimeState.AFKRewardState.Status =
		"AFK 위치 이동 중"

	local Target =
		Part.CFrame
		+ Vector3.new(0, 2, 0)

	local Moved =
		FlyToCapturePoint(
			Target,
			CAPTURE_MOVE_SPEED,
			false
		)

	if not Moved then
		RuntimeState.AFKRewardState.Status =
			"AFK 이동 실패"

		return false
	end

	local EndTime =
		os.clock() + 15

	while Running
		and os.clock() < EndTime do

		if IsAFKActive() then
			RuntimeState.AFKRewardState.Status =
				"AFK 정상 작동중"

			return true
		end

		task.wait(0.5)
	end

	RuntimeState.AFKRewardState.Status =
		"AFK 진입 확인 중"

	return false
end

local function TryCollectAFKRewards()
	if RuntimeState.AFKRewardState.Busy
		or RuntimeState.SpinBusy
		or not RuntimeState.AFKEnabled
		or not IsAFKActive() then

		return false
	end

	local Before =
		GetAFKRewards()

	local BeforeCount,
		BeforeDiamonds =
			CountAFKRewards(Before)

	if BeforeCount <= 0 then
		RuntimeState.AFKRewardState.Status =
			"AFK 정상 작동중"

		return false
	end

	local Button =
		GetAFKCollectButton()

	if not Button then
		RuntimeState.AFKRewardState.Status =
			"AFK 수집 버튼 대기"

		return false
	end

	RuntimeState.AFKRewardState.Busy = true
	RuntimeState.AFKRewardState.Status =
		"AFK 보상 수집 중"

	-- 테스트에서 성공한 방식과 동일하게
	-- 기존 Collect 버튼 연결을 먼저 실행합니다.
	local Clicked =
		AutoRunButton(Button)

	if not Clicked
		and AutoIsVisible(Button) then

		Clicked =
			AutoPhysicalClick(Button)
	end

	if not Clicked then
		RuntimeState.AFKRewardState.Busy = false
		RuntimeState.AFKRewardState.Status =
			"AFK 수집 실패"

		return false
	end

	local Success = false
	local EndTime =
		os.clock() + 8

	while Running
		and os.clock() < EndTime do

		task.wait(0.4)

		local After =
			GetAFKRewards()

		local AfterCount =
			CountAFKRewards(After)

		if AfterCount < BeforeCount then
			Success = true
			break
		end
	end

	if Success then
		RuntimeState.AFKRewardState.CollectCount =
			RuntimeState.AFKRewardState.CollectCount + 1

		RuntimeState.AFKRewardState.Diamonds =
			RuntimeState.AFKRewardState.Diamonds
			+ BeforeDiamonds

		RuntimeState.AFKRewardState.LastCollect =
			os.date("%H:%M:%S")

		RuntimeState.AFKRewardState.Status =
			"AFK 정상 작동중"

		SaveAFKStats()
	else
		RuntimeState.AFKRewardState.Status =
			"AFK 수집 확인 실패"
	end

	RuntimeState.AFKRewardState.Busy = false

	return Success
end

Settings.BASE_RETURN_SUCCESS_DISTANCE = 15
RuntimeState.BaseReturnGuardRunning = false

local function IsAtSavedBase()
	if not RuntimeState.BaseSaved or not RuntimeState.BasePoint then return false end
	local Character = Player.Character
	local Root = Character and Character:FindFirstChild("HumanoidRootPart")
	if not Root then return false end
	return (Root.Position - RuntimeState.BasePoint.Position).Magnitude <= Settings.BASE_RETURN_SUCCESS_DISTANCE
end

local function ReturnToBaseVerified()
	if not RuntimeState.BaseSaved or not RuntimeState.BasePoint then return false end
	for Attempt = 1, 3 do
		RuntimeState.StateText = "기지 복귀 확인 중, " .. tostring(Attempt) .. "/3"
		Teleport(RuntimeState.BasePoint)
		task.wait(3)
		if IsAtSavedBase() then
			RuntimeState.StateText = "기지 복귀 성공"
			return true
		end
		task.wait(5)
	end
	return false
end

local function StartBaseReturnGuard()
	if RuntimeState.BaseReturnGuardRunning then return end
	RuntimeState.BaseReturnGuardRunning = true
	task.spawn(function()
		while Running and RuntimeState.BaseReturnGuardRunning do
			if IsAtSavedBase() then
				RuntimeState.StateText = "기지 복귀 성공, 방치"
				RuntimeState.BaseReturnGuardRunning = false
				break
			end
			RuntimeState.StateText = "기지 복귀 실패, 30초 후 재시도"
			task.wait(30)
			if not Running or not RuntimeState.BaseReturnGuardRunning then break end
			Teleport(RuntimeState.BasePoint)
			task.wait(3)
		end
	end)
end

local function UpdateDiamonds()
	if not RuntimeState.DiamondLabel
		or not RuntimeState.DiamondLabel.Parent then

		RuntimeState.DiamondLabel = FindDiamondLabel()
	end

	if not RuntimeState.DiamondLabel then
		RuntimeState.DiamondStatus = "기지 표시 대기"
		return false
	end

	local Value = ParseNumber(RuntimeState.DiamondLabel.Text)

	if not Value then
		RuntimeState.DiamondStatus = "읽기 실패"
		return false
	end

	if RuntimeState.StartDiamonds == nil then
		if RuntimeState.DiamondStartCandidate == Value then
			RuntimeState.DiamondStartCandidateCount =
				RuntimeState.DiamondStartCandidateCount + 1
		else
			RuntimeState.DiamondStartCandidate = Value
			RuntimeState.DiamondStartCandidateCount = 1
		end

		RuntimeState.CurrentDiamonds = nil
		RuntimeState.DiamondProfit = 0
		RuntimeState.DiamondStatus =
			"초기값 확인 중 "
			.. tostring(RuntimeState.DiamondStartCandidateCount)
			.. "/"
			.. tostring(Settings.DIAMOND_START_CONFIRM_COUNT)

		if RuntimeState.DiamondStartCandidateCount
			< Settings.DIAMOND_START_CONFIRM_COUNT then

			return false
		end

		RuntimeState.StartDiamonds = RuntimeState.DiamondStartCandidate
		RuntimeState.CurrentDiamonds = RuntimeState.DiamondStartCandidate
		RuntimeState.LastDiamondValue = RuntimeState.DiamondStartCandidate
		RuntimeState.DiamondProfit = 0
		RuntimeState.LastDiamondChange = 0
		RuntimeState.LastDiamondChangeTime = "없음"
		RuntimeState.DiamondStatus = "초기값 저장 완료"

		return true
	end

	if RuntimeState.LastDiamondValue ~= nil
		and Value ~= RuntimeState.LastDiamondValue then

		RuntimeState.LastDiamondChange =
			Value - RuntimeState.LastDiamondValue

		RuntimeState.LastDiamondChangeTime =
			os.date("%H:%M:%S")

		RuntimeState.LastDiamondValue = Value
	end

	RuntimeState.CurrentDiamonds = Value
	RuntimeState.DiamondProfit =
		RuntimeState.CurrentDiamonds - RuntimeState.StartDiamonds

	RuntimeState.DiamondStatus = "정상"

	return true
end

local function RefreshDiamondsAfterReturn()
	task.spawn(function()
		task.wait(
			Settings.RETURN_DIAMOND_REFRESH_DELAY
		)

		if Running then
			UpdateDiamonds()
		end

		task.wait(2)

		if Running then
			UpdateDiamonds()
		end
	end)
end

-- 화면 비의존 무료 스핀 V3.7
-- 게임 스핀 창을 열거나 물리 클릭을 사용하지 않습니다.
RuntimeState.SpinDiamondProfit = RuntimeState.SpinDiamondProfit or 0
RuntimeState.SpinnerController = nil
RuntimeState.SpinnerClaimFunction = nil
RuntimeState.SpinnerFreeRemote = nil

local function SpinTableCount(Value)
	if type(Value) ~= "table" then return 0 end
	local Count = 0
	for _ in pairs(Value) do Count = Count + 1 end
	return Count
end

local function FindSpinnerController()
	local Cached = RuntimeState.SpinnerController
	if type(Cached) == "table"
		and type(rawget(Cached, "UnclaimedRewards")) == "table" then
		return Cached
	end
	if type(getgc) ~= "function" then return nil end
	local Ok, Objects = pcall(getgc, true)
	if not Ok or type(Objects) ~= "table" then return nil end
	for Index = 1, math.min(#Objects, 180000) do
		local Candidate = Objects[Index]
		if type(Candidate) == "table" then
			local Object = rawget(Candidate, "Object")
			if typeof(Object) == "Instance" and Object.Name == "Spinner"
				and type(rawget(Candidate, "UnclaimedRewards")) == "table"
				and rawget(Candidate, "IsSpinning") ~= nil then
				RuntimeState.SpinnerController = Candidate
				return Candidate
			end
		end
		if Index % 12000 == 0 then task.wait() end
	end
	return nil
end

local function FindSpinnerFreeRemote()
	local Cached = RuntimeState.SpinnerFreeRemote
	if typeof(Cached) == "Instance" and Cached.Parent then return Cached end
	local Packages = ReplicatedStorage:FindFirstChild("Packages")
	if not Packages then return nil end
	for _, Object in ipairs(Packages:GetDescendants()) do
		if Object.Name == "RequestFreeSpin"
			and (Object:IsA("RemoteEvent") or Object:IsA("RemoteFunction")) then
			RuntimeState.SpinnerFreeRemote = Object
			return Object
		end
	end
	return nil
end

local function GetSpinnerCollectButton(Controller)
	local Spinner = type(Controller) == "table" and rawget(Controller, "Object") or nil
	local Frame = typeof(Spinner) == "Instance" and Spinner:FindFirstChild("Frame") or nil
	local Standard = Frame and Frame:FindFirstChild("Standard")
	local PrizeFrame = Standard and Standard:FindFirstChild("PrizeFrame")
	local Collect = PrizeFrame and PrizeFrame:FindFirstChild("Collect")
	return Collect and Collect:FindFirstChild("CollectButton")
end

local function HasSpinConstant(Constants, Wanted)
	if type(Constants) ~= "table" then return false end
	for _, Value in pairs(Constants) do
		if Value == Wanted then return true end
	end
	return false
end

local function FindSpinnerClaimFunction(Controller)
	local Cached = RuntimeState.SpinnerClaimFunction
	if type(Cached) == "function" then return Cached end
	if type(getconnections) ~= "function" then return nil end
	local GetUpvalues = getupvalues or (debug and debug.getupvalues)
	local GetConstants = getconstants or (debug and debug.getconstants)
	if type(GetUpvalues) ~= "function" or type(GetConstants) ~= "function" then return nil end
	local Button = GetSpinnerCollectButton(Controller)
	if not Button then return nil end
	local Ok, Connections = pcall(getconnections, Button.Activated)
	if not Ok or type(Connections) ~= "table" then return nil end
	for _, Connection in ipairs(Connections) do
		local Wrapper = Connection.Function
		if type(Wrapper) == "function" then
			local ValuesOk, Values = pcall(GetUpvalues, Wrapper)
			if ValuesOk and type(Values) == "table" then
				for _, Candidate in pairs(Values) do
					if type(Candidate) == "function" then
						local ConstantsOk, Constants = pcall(GetConstants, Candidate)
						if ConstantsOk
							and HasSpinConstant(Constants, "CurrentRewardIndex")
							and HasSpinConstant(Constants, "UnclaimedRewards")
							and HasSpinConstant(Constants, "Render") then
							RuntimeState.SpinnerClaimFunction = Candidate
							return Candidate
						end
					end
				end
			end
		end
	end
	return nil
end

local function SpinnerRewardDiamondAmount(Rewards)
	if type(Rewards) ~= "table" then return 0 end
	local Total = 0
	for _, Reward in pairs(Rewards) do
		if type(Reward) == "table" then
			local Kind = string.lower(tostring(rawget(Reward, "Type") or ""))
			if Kind == "diamond" or Kind == "diamonds" or Kind == "gem" or Kind == "gems" then
				Total = Total + (tonumber(rawget(Reward, "DiamondAmount"))
					or tonumber(rawget(Reward, "GemAmount"))
					or tonumber(rawget(Reward, "Amount")) or 0)
			end
		end
	end
	return Total
end

local function GetHeadlessSpinSeconds(Controller)
	if type(Controller) ~= "table" then return nil end
	local Function = rawget(Controller, "GetSecondsUntilFreeSpin")
	if type(Function) ~= "function" then return nil end
	local Ok, Result = pcall(Function, Controller)
	if not Ok then Ok, Result = pcall(Function) end
	if Ok then return tonumber(Result) end
	return nil
end

local function SetHeadlessSpinTimer(Controller, Fallback)
	local Seconds = GetHeadlessSpinSeconds(Controller)
	if Seconds and Seconds >= 0 then
		RuntimeState.NextSpinAt = os.clock() + Seconds
		return Seconds
	end
	RuntimeState.NextSpinAt = os.clock() + Fallback
	return nil
end

local function WaitForSpinCondition(Test, Timeout)
	local Deadline = os.clock() + Timeout
	while Running and os.clock() < Deadline do
		local Ok, Result = pcall(Test)
		if Ok and Result then return true end
		task.wait(0.1)
	end
	return false
end

local function ClaimHeadlessSpinRewards(Controller)
	local Rewards = rawget(Controller, "UnclaimedRewards")
	if SpinTableCount(Rewards) <= 0 then return true end
	local DiamondAmount = SpinnerRewardDiamondAmount(Rewards)
	local ClaimFunction = FindSpinnerClaimFunction(Controller)
	if not ClaimFunction then return false, "수령 함수 없음" end
	local Ok, Reason = pcall(ClaimFunction)
	if not Ok then return false, tostring(Reason) end
	local Cleared = WaitForSpinCondition(function()
		return SpinTableCount(rawget(Controller, "UnclaimedRewards")) == 0
			and (tonumber(rawget(Controller, "CurrentRewardIndex")) or 0) == 0
	end, 10)
	if not Cleared then return false, "수령 확인 실패" end
	RuntimeState.RewardCount = RuntimeState.RewardCount + 1
	RuntimeState.SpinDiamondProfit = RuntimeState.SpinDiamondProfit + DiamondAmount
	return true
end

local function RunFreeSpinOnce()
	local Controller = FindSpinnerController()
	if not Controller then
		RuntimeState.SpinStatus = "스핀 상태 없음, 1분 후"
		RuntimeState.NextSpinAt = os.clock() + Settings.SPIN_TIMER_FAIL_RECHECK
		return false
	end
	local ExistingRewards = rawget(Controller, "UnclaimedRewards")
	if SpinTableCount(ExistingRewards) > 0 then
		RuntimeState.SpinStatus = "남은 보상 자동 수령"
		local Claimed, ClaimReason = ClaimHeadlessSpinRewards(Controller)
		if not Claimed then
			RuntimeState.SpinStatus = "수령 실패: " .. tostring(ClaimReason)
			RuntimeState.NextSpinAt = os.clock() + 30
			return false
		end
		local Seconds = SetHeadlessSpinTimer(Controller, Settings.SPIN_TIMER_FAIL_RECHECK)
		RuntimeState.SpinStatus = Seconds and ("수령 완료, " .. FormatTime(Seconds)) or "수령 완료"
		return true
	end
	local Seconds = GetHeadlessSpinSeconds(Controller)
	if Seconds and Seconds > 1 then
		RuntimeState.NextSpinAt = os.clock() + Seconds
		RuntimeState.SpinStatus = "대기, " .. FormatTime(Seconds)
		return true
	end
	local Remote = FindSpinnerFreeRemote()
	if not Remote then
		RuntimeState.SpinStatus = "무료 스핀 실행 위치 없음"
		RuntimeState.NextSpinAt = os.clock() + Settings.SPIN_TIMER_FAIL_RECHECK
		return false
	end
	RuntimeState.SpinStatus = "화면 없이 무료 스핀 실행"
	local RequestOk = pcall(function()
		if Remote:IsA("RemoteEvent") then Remote:FireServer() else Remote:InvokeServer() end
	end)
	if not RequestOk then
		RuntimeState.SpinStatus = "무료 스핀 요청 실패"
		RuntimeState.NextSpinAt = os.clock() + Settings.SPIN_TIMER_FAIL_RECHECK
		return false
	end
	if not WaitForSpinCondition(function() return rawget(Controller, "IsSpinning") == true end, 5) then
		local Recheck = GetHeadlessSpinSeconds(Controller)
		if Recheck and Recheck > 1 then
			RuntimeState.NextSpinAt = os.clock() + Recheck
			RuntimeState.SpinStatus = "대기, " .. FormatTime(Recheck)
			return true
		end
		RuntimeState.SpinStatus = "스핀 시작 확인 실패"
		RuntimeState.NextSpinAt = os.clock() + 30
		return false
	end
	RuntimeState.SpinCount = RuntimeState.SpinCount + 1
	RuntimeState.LastSpinTime = os.date("%H:%M:%S")
	RuntimeState.SpinStatus = "보상 결과 대기"
	if not WaitForSpinCondition(function()
		return rawget(Controller, "IsSpinning") == false
			and SpinTableCount(rawget(Controller, "UnclaimedRewards")) > 0
	end, 25) then
		RuntimeState.SpinStatus = "보상 결과 확인 실패"
		RuntimeState.NextSpinAt = os.clock() + 30
		return false
	end
	RuntimeState.SpinStatus = "보상 자동 수령"
	local Claimed, ClaimReason = ClaimHeadlessSpinRewards(Controller)
	if not Claimed then
		RuntimeState.SpinStatus = "수령 실패: " .. tostring(ClaimReason)
		RuntimeState.NextSpinAt = os.clock() + 30
		return false
	end
	local NextSeconds = SetHeadlessSpinTimer(Controller, Settings.SPIN_TIMER_FAIL_RECHECK)
	RuntimeState.SpinStatus = NextSeconds and ("완료, " .. FormatTime(NextSeconds)) or "완료, 시간 재확인 대기"
	return true
end

local function RunFreeSpin()
	if RuntimeState.SpinBusy or RuntimeState.Working
		or RuntimeState.AFKRewardState.Busy or not RuntimeState.AutoSpinEnabled then
		return false
	end
	RuntimeState.SpinBusy = true
	local Ok, Success = pcall(RunFreeSpinOnce)
	if not Ok then
		RuntimeState.SpinStatus = "스핀 오류, 1분 후 재시도"
		RuntimeState.NextSpinAt = os.clock() + Settings.SPIN_TIMER_FAIL_RECHECK
		Success = false
	end
	RuntimeState.SpinBusy = false
	return Success == true
end

local function SyncHeadlessSpinTimer()
	if RuntimeState.SpinBusy or not RuntimeState.AutoSpinEnabled then return false end
	local Controller = FindSpinnerController()
	if not Controller then return false end
	local Seconds = GetHeadlessSpinSeconds(Controller)
	if Seconds and Seconds >= 0 then
		RuntimeState.NextSpinAt = os.clock() + Seconds
		return true
	end
	return false
end

local UI = {}


UI.OldGui = PlayerGui:FindFirstChild(Settings.GUI_NAME)

if UI.OldGui then
	UI.OldGui:Destroy()
end

UI.Gui = Instance.new("ScreenGui")
UI.Gui.Name = Settings.GUI_NAME
UI.Gui.ResetOnSpawn = false
UI.Gui.Parent = PlayerGui

local function AddCorner(Object, Radius)
	local C = Instance.new("UICorner")

	C.CornerRadius =
		UDim.new(
			0,
			Radius or 6
		)

	C.Parent = Object
end

local function MakeLabel(
	Parent,
	Text,
	X,
	Y,
	W,
	H,
	Size,
	Bold
)
	local L = Instance.new("TextLabel")

	L.Size =
		UDim2.fromOffset(W, H)

	L.Position =
		UDim2.fromOffset(X, Y)

	L.BackgroundTransparency = 1
	L.Text = Text

	L.TextColor3 =
		Color3.fromRGB(
			235,
			235,
			240
		)

	L.TextSize = math.max(Size or 10, 12)

	if Bold then
		L.Font = Enum.Font.GothamBold
	else
		L.Font = Enum.Font.Gotham
	end

	L.TextXAlignment =
		Enum.TextXAlignment.Left

	L.TextYAlignment =
		Enum.TextYAlignment.Top

	L.Parent = Parent

	return L
end

local function MakeButton(
	Parent,
	Text,
	X,
	Y,
	W,
	H
)
	local B = Instance.new("TextButton")

	B.Size =
		UDim2.fromOffset(W, H)

	B.Position =
		UDim2.fromOffset(X, Y)

	B.BackgroundColor3 =
		Color3.fromRGB(
			48,
			48,
			57
		)

	B.BorderSizePixel = 0
	B.Text = Text

	B.TextColor3 =
		Color3.fromRGB(
			245,
			245,
			250
		)

	B.TextSize = 12
	B.Font = Enum.Font.GothamBold
	B.Parent = Parent

	AddCorner(B, 5)

	return B
end

UI.Main = Instance.new("Frame")

UI.Main.Size =
	UDim2.fromOffset(
		300,
		360
	)

UI.Main.Position =
	UDim2.new(
		0.5,
		-150,
		0.5,
		-180
	)

UI.Main.BackgroundColor3 =
	Color3.fromRGB(
		20,
		20,
		25
	)

UI.Main.BorderSizePixel = 0
UI.Main.Parent = UI.Gui

-- 다클라에서 화면을 덜 가리도록 전체 UI를 조금 축소합니다.
UI.MainScale = Instance.new("UIScale")
UI.MainScale.Scale = 1.00
UI.MainScale.Parent = UI.Main

AddCorner(UI.Main, 7)

UI.Header = Instance.new("Frame")

UI.Header.Size =
	UDim2.new(
		1,
		0,
		0,
		28
	)

UI.Header.BackgroundColor3 =
	Color3.fromRGB(
		28,
		28,
		34
	)

UI.Header.BorderSizePixel = 0
UI.Header.Parent = UI.Main

AddCorner(UI.Header, 7)

UI.Title =
	MakeLabel(
		UI.Header,
		"쇼타임 통합 자동팜 V1.1",
		9,
		7,
		210,
		16,
		12,
		true
	)

UI.Title.Active = true

UI.CloseButton =
	MakeButton(
		UI.Header,
		"X",
		548,
		3,
		27,
		22
	)

UI.CloseButton.Position =
	UDim2.new(
		1,
		-32,
		0,
		3
	)

UI.CloseButton.BackgroundColor3 =
	Color3.fromRGB(
		145,
		55,
		55
	)

UI.MinimizeButton =
	MakeButton(
		UI.Header,
		"─",
		516,
		3,
		27,
		22
	)

UI.MinimizeButton.Position =
	UDim2.new(
		1,
		-62,
		0,
		3
	)

UI.MinimizeButton.TextSize = 14

UI.HeaderFPS =
	MakeButton(
		UI.Header,
		"FPS 15 · 꺼짐",
		0,
		3,
		112,
		22
	)
UI.HeaderFPS.TextSize = 11

UI.HeaderFPS.Position =
	UDim2.new(
		1,
		-178,
		0,
		3
	)

UI.HeaderFPS.TextXAlignment =
	Enum.TextXAlignment.Center

UI.Left = Instance.new("Frame")

UI.Left.Size =
	UDim2.fromOffset(
		288,
		182
	)

UI.Left.Position =
	UDim2.fromOffset(
		6,
		33
	)

UI.Left.BackgroundColor3 =
	Color3.fromRGB(
		26,
		26,
		32
	)

UI.Left.BorderSizePixel = 0
UI.Left.Parent = UI.Main

AddCorner(UI.Left, 6)

UI.Right = Instance.new("Frame")

UI.Right.Size =
	UDim2.fromOffset(
		288,
		138
	)

UI.Right.Position =
	UDim2.fromOffset(
		6,
		216
	)

UI.Right.BackgroundColor3 =
	Color3.fromRGB(
		26,
		26,
		32
	)

UI.Right.BorderSizePixel = 0
UI.Right.Parent = UI.Main

AddCorner(UI.Right, 6)

UI.StatusCard = Instance.new("Frame")

UI.StatusCard.Size =
	UDim2.fromOffset(
		328,
		58
	)

UI.StatusCard.Position =
	UDim2.fromOffset(
		6,
		5
	)

UI.StatusCard.BackgroundColor3 =
	Color3.fromRGB(
		34,
		34,
		41
	)

UI.StatusCard.BorderSizePixel = 0
UI.StatusCard.Parent = UI.Left

AddCorner(UI.StatusCard, 5)

MakeLabel(
	UI.StatusCard,
	"작동 상태",
	7,
	5,
	90,
	14,
	12,
	true
)

UI.AccountNameLabel =
	MakeLabel(
		UI.StatusCard,
		"계정: " .. Player.Name,
		100,
		5,
		220,
		14,
		12,
		true
	)

UI.AccountNameLabel.TextXAlignment =
	Enum.TextXAlignment.Right

UI.Status =
	MakeLabel(
		UI.StatusCard,
		"",
		7,
		20,
		314,
		35,
		11,
		false
	)

UI.Menu = Instance.new("Frame")

UI.Menu.Size =
	UDim2.fromOffset(
		328,
		26
	)

UI.Menu.Position =
	UDim2.fromOffset(
		6,
		68
	)

UI.Menu.BackgroundColor3 =
	Color3.fromRGB(
		31,
		31,
		38
	)

UI.Menu.BorderSizePixel = 0
UI.Menu.Parent = UI.Left

AddCorner(UI.Menu, 5)

UI.WorkTab =
	MakeButton(
		UI.Menu,
		"작업",
		3,
		3,
		78,
		20
	)

UI.MoveTab =
	MakeButton(
		UI.Menu,
		"이동",
		84,
		3,
		78,
		20
	)

UI.SettingsTab =
	MakeButton(
		UI.Menu,
		"설정",
		165,
		3,
		78,
		20
	)

UI.SpinTab =
	MakeButton(
		UI.Menu,
		"스핀",
		246,
		3,
		79,
		20
	)

UI.Content = Instance.new("Frame")

UI.Content.Size =
	UDim2.fromOffset(
		328,
		143
	)

UI.Content.Position =
	UDim2.fromOffset(
		6,
		99
	)

UI.Content.BackgroundColor3 =
	Color3.fromRGB(
		30,
		30,
		36
	)

UI.Content.BorderSizePixel = 0
UI.Content.Parent = UI.Left

AddCorner(UI.Content, 5)

UI.Pages = {}

local function NewPage(Name)
	local Page = Instance.new("Frame")

	Page.Name = Name

	Page.Size =
		UDim2.new(
			1,
			0,
			1,
			0
		)

	Page.BackgroundTransparency = 1
	Page.Visible = false
	Page.Parent = UI.Content

	UI.Pages[Name] = Page

	return Page
end

UI.WorkPage =
	NewPage("작업")

UI.MovePage =
	NewPage("이동")

UI.SettingsPage =
	NewPage("설정")

UI.SpinPage =
	NewPage("스핀")

UI.StartButton =
	MakeButton(
		UI.WorkPage,
		"점령 시작",
		7,
		7,
		153,
		28
	)

UI.StopButton =
	MakeButton(
		UI.WorkPage,
		"즉시 정지",
		168,
		7,
		153,
		28
	)

UI.StopButton.BackgroundColor3 =
	Color3.fromRGB(
		135,
		55,
		55
	)

MakeLabel(
	UI.WorkPage,
	"점령1 01:05    점령2 01:35\n점령지 이동 속도 150, 걷는 동작, 건물 관통\n완료 후 기지 복귀, 게임 UI OFF",
	9,
	46,
	310,
	60,
	9,
	false
)

UI.Point1Button =
	MakeButton(
		UI.MovePage,
		"점령 1",
		7,
		7,
		153,
		27
	)

UI.Point2Button =
	MakeButton(
		UI.MovePage,
		"점령 2",
		168,
		7,
		153,
		27
	)

UI.SaveBaseButton =
	MakeButton(
		UI.MovePage,
		"현재 위치 기지 저장",
		7,
		42,
		314,
		27
	)

UI.BaseButton =
	MakeButton(
		UI.MovePage,
		"자기기지 이동",
		7,
		77,
		314,
		27
	)

UI.BaseInfo =
	MakeLabel(
		UI.MovePage,
		"",
		9,
		112,
		310,
		25,
		11,
		false
	)

UI.AFKButton =
	MakeButton(
		UI.SettingsPage,
		"AFK, 켜짐",
		7,
		7,
		153,
		27
	)

UI.RenderButton =
	MakeButton(
		UI.SettingsPage,
		"3D, 켜짐",
		168,
		7,
		153,
		27
	)

UI.GameUIButton =
	MakeButton(
		UI.SettingsPage,
		"게임 UI, 켜짐",
		7,
		42,
		314,
		27
	)

UI.ReturnButton =
	MakeButton(
		UI.SettingsPage,
		"점령 후 기지 복귀, 켜짐",
		7,
		77,
		314,
		27
	)

UI.AutoGameUIOffButton =
	MakeButton(
		UI.SettingsPage,
		"클랜서버 60초 UI OFF, 켜짐",
		7,
		108,
		314,
		27
	)


UI.ResetProfitButton =
	MakeButton(
		UI.SettingsPage,
		"다이아 수익 초기화",
		7,
		143,
		153,
		24
	)

UI.MoveSpeedButton =
	MakeButton(
		UI.SettingsPage,
		"이동 속도, 300",
		168,
		143,
		153,
		24
	)

UI.AutoSpinButton =
	MakeButton(
		UI.SpinPage,
		"자동 무료 스핀, 켜짐",
		7,
		7,
		314,
		27
	)

UI.TestSpinButton =
	MakeButton(
		UI.SpinPage,
		"무료 스핀 테스트",
		7,
		42,
		314,
		27
	)

UI.SpinInfo =
	MakeLabel(
		UI.SpinPage,
		"",
		9,
		79,
		310,
		56,
		11,
		false
	)


UI.SpeedPopup = Instance.new("Frame")
UI.SpeedPopup.Size =
	UDim2.fromOffset(
		330,
		205
	)
UI.SpeedPopup.Position =
	UDim2.new(
		0.5,
		-165,
		0.5,
		-102
	)
UI.SpeedPopup.BackgroundColor3 =
	Color3.fromRGB(
		24,
		24,
		30
	)
UI.SpeedPopup.BorderSizePixel = 0
UI.SpeedPopup.Visible = false
UI.SpeedPopup.ZIndex = 20
UI.SpeedPopup.Parent = UI.Main

AddCorner(UI.SpeedPopup, 7)

UI.SpeedPopupTitle =
	MakeLabel(
		UI.SpeedPopup,
		"점령지 이동 속도",
		12,
		10,
		250,
		20,
		12,
		true
	)

UI.SpeedPopupTitle.ZIndex = 21

UI.SpeedValueLabel =
	MakeLabel(
		UI.SpeedPopup,
		"",
		12,
		38,
		300,
		20,
		10,
		false
	)

UI.SpeedValueLabel.ZIndex = 21

UI.SpeedMinusButton =
	MakeButton(
		UI.SpeedPopup,
		"-10",
		12,
		68,
		92,
		32
	)

UI.SpeedMinusButton.ZIndex = 21

UI.SpeedPlusButton =
	MakeButton(
		UI.SpeedPopup,
		"+10",
		119,
		68,
		92,
		32
	)

UI.SpeedPlusButton.ZIndex = 21

UI.SpeedCloseButton =
	MakeButton(
		UI.SpeedPopup,
		"닫기",
		226,
		68,
		92,
		32
	)

UI.SpeedCloseButton.ZIndex = 21

UI.DefaultSpeedLabel =
	MakeLabel(
		UI.SpeedPopup,
		"기본값 직접 입력",
		12,
		112,
		120,
		18,
		9,
		true
	)

UI.DefaultSpeedLabel.ZIndex = 21

UI.DefaultSpeedBox =
	Instance.new("TextBox")

UI.DefaultSpeedBox.Size =
	UDim2.fromOffset(
		95,
		30
	)

UI.DefaultSpeedBox.Position =
	UDim2.fromOffset(
		12,
		136
	)

UI.DefaultSpeedBox.BackgroundColor3 =
	Color3.fromRGB(
		42,
		42,
		50
	)

UI.DefaultSpeedBox.BorderSizePixel = 0
UI.DefaultSpeedBox.Text =
	tostring(
		math.floor(
			CAPTURE_MOVE_DEFAULT
		)
	)

UI.DefaultSpeedBox.PlaceholderText = "10 ~ 500"
UI.DefaultSpeedBox.TextColor3 =
	Color3.fromRGB(
		245,
		245,
		250
	)

UI.DefaultSpeedBox.TextSize = 11
UI.DefaultSpeedBox.Font = Enum.Font.GothamBold
UI.DefaultSpeedBox.ClearTextOnFocus = false
UI.DefaultSpeedBox.ZIndex = 21
UI.DefaultSpeedBox.Parent = UI.SpeedPopup

AddCorner(UI.DefaultSpeedBox, 5)

UI.SaveDefaultSpeedButton =
	MakeButton(
		UI.SpeedPopup,
		"기본값 저장",
		117,
		136,
		95,
		30
	)

UI.SaveDefaultSpeedButton.ZIndex = 21

UI.ApplyDefaultSpeedButton =
	MakeButton(
		UI.SpeedPopup,
		"기본값 적용",
		222,
		136,
		96,
		30
	)

UI.ApplyDefaultSpeedButton.ZIndex = 21

UI.SpeedHelpLabel =
	MakeLabel(
		UI.SpeedPopup,
		"범위 10 ~ 500, 저장한 기본값은 다음 실행에도 사용",
		12,
		176,
		305,
		18,
		10,
		false
	)

UI.SpeedHelpLabel.ZIndex = 21


UI.FPSPopup = Instance.new("Frame")
UI.FPSPopup.Size = UDim2.fromOffset(260, 205)
UI.FPSPopup.Position = UDim2.new(0.5, -130, 0.5, -102)
UI.FPSPopup.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
UI.FPSPopup.BorderSizePixel = 0
UI.FPSPopup.Visible = false
UI.FPSPopup.ZIndex = 30
UI.FPSPopup.Parent = UI.Gui
AddCorner(UI.FPSPopup, 7)

UI.FPSTitle =
	MakeLabel(
		UI.FPSPopup,
		"FPS 제한",
		10,
		8,
		180,
		22,
		13,
		true
	)

UI.FPSTitle.ZIndex = 31

UI.FPSClose =
	MakeButton(
		UI.FPSPopup,
		"X",
		222,
		6,
		28,
		25
	)

UI.FPSClose.ZIndex = 31

UI.FPSToggle =
	MakeButton(
		UI.FPSPopup,
		"FPS 제한, 켜짐",
		10,
		40,
		240,
		30
	)

UI.FPSToggle.ZIndex = 31

UI.FPS5 =
	MakeButton(
		UI.FPSPopup,
		"5",
		10,
		80,
		72,
		30
	)

UI.FPS15 =
	MakeButton(
		UI.FPSPopup,
		"15",
		94,
		80,
		72,
		30
	)

UI.FPS30 =
	MakeButton(
		UI.FPSPopup,
		"30",
		178,
		80,
		72,
		30
	)

UI.FPSBox = Instance.new("TextBox")
UI.FPSBox.Size = UDim2.fromOffset(115, 30)
UI.FPSBox.Position = UDim2.fromOffset(10, 120)
UI.FPSBox.BackgroundColor3 = Color3.fromRGB(42, 42, 50)
UI.FPSBox.BorderSizePixel = 0
UI.FPSBox.Text = tostring(Settings.FPS_CAP)
UI.FPSBox.PlaceholderText = "1 ~ 240"
UI.FPSBox.TextColor3 = Color3.fromRGB(245, 245, 250)
UI.FPSBox.TextSize = 12
UI.FPSBox.Font = Enum.Font.GothamBold
UI.FPSBox.ClearTextOnFocus = false
UI.FPSBox.ZIndex = 31
UI.FPSBox.Parent = UI.FPSPopup
AddCorner(UI.FPSBox, 5)

UI.FPSApply =
	MakeButton(
		UI.FPSPopup,
		"직접 적용",
		135,
		120,
		115,
		30
	)

UI.FPSApply.ZIndex = 31

UI.FPSState =
	MakeLabel(
		UI.FPSPopup,
		"",
		10,
		162,
		240,
		28,
		12,
		true
	)

UI.FPSState.ZIndex = 31

UI.FPSButton =
	MakeButton(
		UI.SettingsPage,
		"FPS 설정, 15",
		7,
		174,
		314,
		27
	)

UI.ProfitCard = Instance.new("Frame")

UI.ProfitCard.Size =
	UDim2.fromOffset(
		210,
		96
	)

UI.ProfitCard.Position =
	UDim2.fromOffset(
		6,
		5
	)

UI.ProfitCard.BackgroundColor3 =
	Color3.fromRGB(
		35,
		35,
		43
	)

UI.ProfitCard.BorderSizePixel = 0
UI.ProfitCard.Parent = UI.Right

AddCorner(UI.ProfitCard, 5)

MakeLabel(
	UI.ProfitCard,
	"다이아 총수익",
	7,
	5,
	150,
	17,
	12,
	true
)

UI.ProfitValue =
	MakeLabel(
		UI.ProfitCard,
		"+0",
		7,
		23,
		195,
		29,
		22,
		true
	)

UI.CurrentDiamondText =
	MakeLabel(
		UI.ProfitCard,
		"현재, 탐지 중",
		7,
		56,
		195,
		16,
		13,
		true
	)

UI.StartDiamondText =
	MakeLabel(
		UI.ProfitCard,
		"시작, 탐지 중",
		7,
		73,
		195,
		14,
		11,
		false
	)

UI.RecentDiamondText =
	MakeLabel(
		UI.ProfitCard,
		"최근, 없음",
		7,
		88,
		195,
		13,
		11,
		false
	)

UI.SpinCard = Instance.new("Frame")

UI.SpinCard.Size =
	UDim2.fromOffset(
		210,
		75
	)

UI.SpinCard.Position =
	UDim2.fromOffset(
		6,
		106
	)

UI.SpinCard.BackgroundColor3 =
	Color3.fromRGB(
		34,
		34,
		41
	)

UI.SpinCard.BorderSizePixel = 0
UI.SpinCard.Parent = UI.Right

AddCorner(UI.SpinCard, 5)

MakeLabel(
	UI.SpinCard,
	"무료 스핀",
	7,
	5,
	100,
	14,
	10,
	true
)

UI.SpinSummary =
	MakeLabel(
		UI.SpinCard,
		"",
		7,
		22,
		195,
		48,
		10,
		false
	)

UI.SystemCard = Instance.new("Frame")

UI.SystemCard.Size =
	UDim2.fromOffset(
		210,
		56
	)

UI.SystemCard.Position =
	UDim2.fromOffset(
		6,
		186
	)

UI.SystemCard.BackgroundColor3 =
	Color3.fromRGB(
		34,
		34,
		41
	)

UI.SystemCard.BorderSizePixel = 0
UI.SystemCard.Parent = UI.Right

AddCorner(UI.SystemCard, 5)

UI.SystemInfo =
	MakeLabel(
		UI.SystemCard,
		"",
		7,
		6,
		195,
		45,
		10,
		false
	)

UI.CompactMode = false

UI.Compact = Instance.new("Frame")
UI.Compact.Size = UDim2.fromOffset(300, 252)
UI.Compact.Position = UDim2.fromOffset(6, 33)
UI.Compact.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
UI.Compact.BorderSizePixel = 0
UI.Compact.Visible = false
UI.Compact.Parent = UI.Main
AddCorner(UI.Compact, 6)

UI.CompactAccount =
	MakeLabel(UI.Compact, Player.Name, 8, 7, 170, 22, 13, true)

UI.CompactExpandButton =
	MakeButton(UI.Compact, "확대", 236, 5, 56, 24)
UI.CompactExpandButton.TextSize = 11

UI.CompactServer =
	MakeLabel(UI.Compact, "서버 확인중", 178, 7, 56, 22, 11, true)

UI.CompactStatus =
	MakeLabel(UI.Compact, "", 8, 33, 284, 174, 12, true)
UI.CompactStatus.TextYAlignment = Enum.TextYAlignment.Top
UI.CompactStatus.RichText = true

UI.CompactCombinedButton =
	MakeButton(UI.Compact, "3D + UI 끄기", 8, 213, 135, 30)
UI.CompactCombinedButton.TextSize = 11

UI.CompactQuickButton =
	MakeButton(UI.Compact, "빠른 작업", 157, 213, 135, 30)
UI.CompactQuickButton.TextSize = 11

UI.QuickPopup = Instance.new("Frame")
UI.QuickPopup.Size = UDim2.fromOffset(230, 244)
UI.QuickPopup.Position = UDim2.new(0.5, -115, 0.5, -122)
UI.QuickPopup.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
UI.QuickPopup.BorderSizePixel = 0
UI.QuickPopup.Visible = false
UI.QuickPopup.ZIndex = 50

-- 최소창 안에 넣으면 다른 프레임에 가려질 수 있어서
-- ScreenGui 바로 아래에 띄웁니다.
UI.QuickPopup.Parent = UI.Gui

AddCorner(UI.QuickPopup, 7)

UI.QuickTitle =
	MakeLabel(
		UI.QuickPopup,
		"빠른 작업",
		10,
		8,
		170,
		24,
		14,
		true
	)

UI.QuickTitle.ZIndex = 51

UI.QuickX =
	MakeButton(
		UI.QuickPopup,
		"X",
		194,
		6,
		28,
		26
	)

UI.QuickX.ZIndex = 51
UI.QuickX.TextSize = 13

UI.QuickStart =
	MakeButton(
		UI.QuickPopup,
		"작업 시작",
		10,
		42,
		210,
		28
	)

UI.QuickStop =
	MakeButton(
		UI.QuickPopup,
		"작업 중지",
		10,
		76,
		210,
		28
	)

UI.QuickPoint1 =
	MakeButton(
		UI.QuickPopup,
		"1번 점령지점 이동",
		10,
		110,
		210,
		28
	)

UI.QuickPoint2 =
	MakeButton(
		UI.QuickPopup,
		"2번 점령지점 이동",
		10,
		144,
		210,
		28
	)

UI.QuickBase =
	MakeButton(
		UI.QuickPopup,
		"자기 기지로 이동",
		10,
		178,
		210,
		28
	)

UI.QuickClose =
	MakeButton(
		UI.QuickPopup,
		"아무 작업 안 함, 닫기",
		10,
		212,
		210,
		24
	)

for _, Object in ipairs(
	{
		UI.QuickStart,
		UI.QuickStop,
		UI.QuickPoint1,
		UI.QuickPoint2,
		UI.QuickBase,
		UI.QuickClose
	}
) do
	Object.ZIndex = 51
	Object.TextSize = 11
end

-- 선택한 탭에 맞춰 확대창 높이를 자동 조절합니다.
UI.ApplyExpandedSize = function(PageName)
	local Height =
		PageName == "설정"
		and 304
		or 252

	UI.Main.Size =
		UDim2.fromOffset(
			300,
			Height
		)

	UI.Main.Position =
		UDim2.new(
			0.5,
			-150,
			0.5,
			-math.floor(Height / 2)
		)
end

UI.SetCompactMode = function(State)
	UI.CompactMode = State

	if UI.QuickPopup then
		UI.QuickPopup.Visible = false
	end

	if UI.FPSPopup then
		UI.FPSPopup.Visible = false
	end

	if State then
		UI.ExpandedScale.Scale = 1
		UI.ExpandedRightScale.Scale = 1
		UI.Left.Visible = false
		UI.Right.Visible = false
		UI.Compact.Visible = true
		UI.MinimizeButton.Visible = true

		UI.Main.Size =
			UDim2.fromOffset(
				312,
				292
			)

		UI.Main.Position =
			UDim2.new(
				0.5,
				-156,
				0.5,
				-146
			)
	else
		UI.ExpandedScale.Scale = 0.86
		UI.ExpandedRightScale.Scale = 0.84
		UI.Left.Visible = true
		UI.Right.Visible = false
		UI.Compact.Visible = false
		UI.MinimizeButton.Visible = true

		UI.ApplyExpandedSize(
			UI.CurrentPage or "작업"
		)
	end
end


UI.ExpandedScale = Instance.new("UIScale")
UI.ExpandedScale.Scale = 1
UI.ExpandedScale.Parent = UI.Left

UI.ExpandedRightScale = Instance.new("UIScale")
UI.ExpandedRightScale.Scale = 1
UI.ExpandedRightScale.Parent = UI.Right


local function ShowPage(Name)
	UI.CurrentPage = Name

	for PageName, Page in pairs(UI.Pages) do
		Page.Visible =
			PageName == Name
	end

	local Selected =
		Color3.fromRGB(
			68,
			68,
			82
		)

	local Normal =
		Color3.fromRGB(
			48,
			48,
			57
		)

	UI.WorkTab.BackgroundColor3 =
		Name == "작업"
		and Selected
		or Normal

	UI.MoveTab.BackgroundColor3 =
		Name == "이동"
		and Selected
		or Normal

	UI.SettingsTab.BackgroundColor3 =
		Name == "설정"
		and Selected
		or Normal

	UI.SpinTab.BackgroundColor3 =
		Name == "스핀"
		and Selected
		or Normal

	if not UI.CompactMode then
		UI.ApplyExpandedSize(Name)
	end
end

local function Refresh()
	local IdleText = "시작 전"

	if RuntimeState.IdleStart then
		IdleText =
			FormatDuration(
				os.clock() - RuntimeState.IdleStart
			)
	end

	if RuntimeState.IdleStart
		and Revenue.StartDiamonds == nil
		and RuntimeState.CurrentDiamonds ~= nil then

		Revenue.StartDiamonds = RuntimeState.CurrentDiamonds
		Revenue.StartTime =
			Revenue.StartTime or RuntimeState.IdleStart
	end

	local HourlyProfit = nil
	local DayProfit = nil

	if Revenue.StartTime
		and Revenue.StartDiamonds
		and RuntimeState.CurrentDiamonds then

		local RevenueSeconds =
			math.max(
				1,
				os.clock()
				- Revenue.StartTime
			)

		local RevenueProfit =
			RuntimeState.CurrentDiamonds
			- Revenue.StartDiamonds

		HourlyProfit =
			math.floor(
				RevenueProfit
				/ RevenueSeconds
				* 3600
			)

		DayProfit =
			HourlyProfit * 24
	end

	local ProfitPrefix = ""

	if RuntimeState.StartDiamonds == nil
		or RuntimeState.CurrentDiamonds == nil then

		UI.ProfitValue.Text = "탐지 중"
	else
		if RuntimeState.DiamondProfit >= 0 then
			ProfitPrefix = "+"
		end

		UI.ProfitValue.Text =
			ProfitPrefix
			.. FormatNumber(
				RuntimeState.DiamondProfit
			)
	end

	if RuntimeState.StartDiamonds == nil
		or RuntimeState.CurrentDiamonds == nil then

		UI.CurrentDiamondText.Text =
			"현재, 확인 중"

		UI.StartDiamondText.Text =
			"시작, 확인 중"
	else
		UI.CurrentDiamondText.Text =
			"현재, "
			.. FormatNumber(
				RuntimeState.CurrentDiamonds
			)

		UI.StartDiamondText.Text =
			"시작, "
			.. FormatNumber(
				RuntimeState.StartDiamonds
			)
	end

	UI.RecentDiamondText.Text =
		"최근, "
		.. FormatSignedNumber(
			RuntimeState.LastDiamondChange
		)
		.. " "
		.. RuntimeState.LastDiamondChangeTime

	local RemainingText = "없음"

	if RuntimeState.RemainingTime > 0 then
		RemainingText =
			FormatCountdown(
				RuntimeState.RemainingTime
			)
	end

	UI.Status.Text =
		RuntimeState.StateText
		.. "    남은 "
		.. RemainingText
		.. "\n방치 "
		.. IdleText

	local NextText = "확인 중"

	if RuntimeState.NextSpinAt then
		local LeftTime =
			RuntimeState.NextSpinAt
			- os.clock()

		if LeftTime > 0 then
			NextText =
				FormatTime(
					LeftTime
				)
		else
			NextText = "확인 예정"
		end
	end

	UI.SpinSummary.Text =
		"스핀 "
		.. tostring(RuntimeState.SpinCount)
		.. "회, 보상 "
		.. tostring(RuntimeState.RewardCount)
		.. "개"
		.. "\n다음 "
		.. NextText
		.. "\n"
		.. RuntimeState.SpinStatus

	UI.SpinInfo.Text =
		"총 스핀 "
		.. tostring(RuntimeState.SpinCount)
		.. "회, 보상 "
		.. tostring(RuntimeState.RewardCount)
		.. "개"
		.. "\n마지막 "
		.. RuntimeState.LastSpinTime
		.. "\n다음 "
		.. NextText
		.. "\n상태 "
		.. RuntimeState.SpinStatus

	UI.BaseInfo.Text =
		"기지 "
		.. (
			RuntimeState.BaseSaved
			and "저장됨"
			or "없음"
		)
		.. "    다이아 "
		.. RuntimeState.DiamondStatus

	UI.AFKButton.Text =
		RuntimeState.AFKEnabled
		and "AFK, 켜짐"
		or "AFK, 꺼짐"

	UI.RenderButton.Text =
		RuntimeState.RenderingEnabled
		and "3D, 켜짐"
		or "3D, 꺼짐"

	UI.GameUIButton.Text =
		RuntimeState.GameUIVisible
		and "게임 UI, 켜짐"
		or "게임 UI, 꺼짐"

	UI.AutoGameUIOffButton.Text =
		RuntimeState.AutoGameUIOff60
		and "클랜서버 60초 UI OFF, 켜짐"
		or "클랜서버 60초 UI OFF, 꺼짐"

	UI.ReturnButton.Text =
		RuntimeState.AutoReturnBase
		and "점령 후 기지 복귀, 켜짐"
		or "점령 후 기지 복귀, 꺼짐"

	UI.AutoSpinButton.Text =
		RuntimeState.AutoSpinEnabled
		and "자동 무료 스핀, 켜짐"
		or "자동 무료 스핀, 꺼짐"

	UI.MoveSpeedButton.Text =
		"이동 속도, "
		.. tostring(
			math.floor(
				CAPTURE_MOVE_SPEED
			)
		)

	UI.SpeedValueLabel.Text =
		"현재 "
		.. tostring(
			math.floor(
				CAPTURE_MOVE_SPEED
			)
		)
		.. "    기본값 "
		.. tostring(
			math.floor(
				CAPTURE_MOVE_DEFAULT
			)
		)

	UI.SystemInfo.Text =
		"기지 "
		.. (
			RuntimeState.BaseSaved
			and "저장"
			or "없음"
		)
		.. "  AFK "
		.. tostring(RuntimeState.AFKCount)
		.. "회"
		.. "\n3D "
		.. (
			RuntimeState.RenderingEnabled
			and "ON"
			or "OFF"
		)
		.. "  UI "
		.. (
			RuntimeState.GameUIVisible
			and "ON"
			or "OFF"
		)

	local CompactState =
		RuntimeState.IdleStart
		and "점령 유지"
		or RuntimeState.StateText

	UI.CompactAccount.Text =
		Player.Name
		.. "  방치 "
		.. IdleText

	if ServerDisplayState == "클랜서버" then
		UI.CompactServer.Text = "클랜서버"
		UI.CompactServer.TextColor3 = Color3.fromRGB(80, 220, 110)
	elseif ServerDisplayState == "일반서버" then
		UI.CompactServer.Text = "일반서버"
		UI.CompactServer.TextColor3 = Color3.fromRGB(255, 85, 85)
	else
		UI.CompactServer.Text = "확인중"
		UI.CompactServer.TextColor3 = Color3.fromRGB(220, 220, 220)
	end

	local CompactProfit =
		RuntimeState.StartDiamonds
		and RuntimeState.CurrentDiamonds
		and (
			(
				RuntimeState.DiamondProfit >= 0
				and "+"
				or ""
			)
			.. FormatNumber(
				RuntimeState.DiamondProfit
			)
		)
		or "확인 중"

	local CompactHourly =
		HourlyProfit
		and (
			(
				HourlyProfit >= 0
				and "+"
				or ""
			)
			.. FormatNumber(
				HourlyProfit
			)
		)
		or "측정 중"

	local CompactDay =
		DayProfit
		and (
			(
				DayProfit >= 0
				and "+"
				or ""
			)
			.. FormatNumber(
				DayProfit
			)
		)
		or "측정 중"

	local CompactDiamond =
		RuntimeState.CurrentDiamonds
		and FormatNumber(
			RuntimeState.CurrentDiamonds
		)
		or "확인 중"

	local CompactStartDiamond =
		RuntimeState.StartDiamonds
		and FormatNumber(RuntimeState.StartDiamonds)
		or "확인 중"

	local IdlePreventText = "대기"

	if Settings.AFK_IDLE_PREVENT_ENABLED then
		if RuntimeState.AFKNextIdleInputAt then
			local IdleLeft =
				math.max(
					0,
					RuntimeState.AFKNextIdleInputAt - os.clock()
				)

			IdlePreventText =
				FormatTime(IdleLeft)
		else
			IdlePreventText = "00:05:00"
		end
	elseif not Settings.AFK_IDLE_PREVENT_ENABLED then
		IdlePreventText = "꺼짐"
	end

	UI.CompactStatus.Text =
		"상태 : " .. CompactState
		.. "\n수익 : " .. CompactProfit
		.. "\n시작 다이아 : " .. CompactStartDiamond
		.. '\n현재 다이아 : <font color="rgb(190,110,255)">'
		.. CompactDiamond
		.. "</font>"
		.. "\n시간당 : " .. CompactHourly
		.. "\n24시간 예상 : " .. CompactDay
		.. "\n스핀 다음 : " .. NextText
		.. "\n보상 수집 : " .. tostring(RuntimeState.RewardCount) .. "회"
		.. "\n"
		.. RuntimeState.AFKRewardState.Status
		.. " 수령("
		.. tostring(RuntimeState.AFKRewardState.CollectCount)
		.. "번)"
		.. "\nAFK 다이아 : "
		.. FormatNumber(RuntimeState.AFKRewardState.Diamonds)
		.. "\n유휴 방지 : "
		.. IdlePreventText

	UI.FPSButton.Text =
		"FPS 설정, "
		.. tostring(Settings.FPS_CAP)

	UI.FPSToggle.Text =
		FPS_ENABLED
		and "FPS 제한, 켜짐"
		or "FPS 제한, 꺼짐, 60"

	local FPSDisplay =
		FPS_ENABLED
		and Settings.FPS_CAP
		or 60

	if FPSDisplay <= 5 then
		UI.FPSState.TextColor3 =
			Color3.fromRGB(80, 220, 110)

		UI.HeaderFPS.TextColor3 =
			Color3.fromRGB(80, 220, 110)
	elseif FPSDisplay <= 15 then
		UI.FPSState.TextColor3 =
			Color3.fromRGB(255, 220, 80)

		UI.HeaderFPS.TextColor3 =
			Color3.fromRGB(255, 220, 80)
	else
		UI.FPSState.TextColor3 =
			Color3.fromRGB(255, 85, 85)

		UI.HeaderFPS.TextColor3 =
			Color3.fromRGB(255, 85, 85)
	end

	UI.FPSState.Text =
		"현재 FPS "
		.. tostring(FPSDisplay)

	UI.HeaderFPS.Text =
		FPS_ENABLED
		and ("FPS " .. tostring(FPSDisplay) .. " · 켜짐")
		or "FPS 제한 · 꺼짐"

	if not FPS_ENABLED then
		UI.HeaderFPS.TextColor3 = Color3.fromRGB(190, 190, 200)
	end

	local BothOn =
		RuntimeState.RenderingEnabled
		and RuntimeState.GameUIVisible

	UI.CompactCombinedButton.Text =
		BothOn
		and "3D + UI 끄기"
		or "3D + UI 켜기"
end

local function WaitForAliveCharacter()
	while Running and RuntimeState.Working do
		local Character = Player.Character
		local Humanoid =
			Character
			and Character:FindFirstChildOfClass("Humanoid")

		local Root =
			Character
			and Character:FindFirstChild("HumanoidRootPart")

		if Character
			and Humanoid
			and Root
			and Humanoid.Health > 0 then

			return Character, Humanoid, Root
		end

		RuntimeState.StateText = "리스폰 대기 중"
		task.wait(0.5)
	end

	return nil, nil, nil
end

local function WaitCaptureAlive(Seconds, PointName)
	local Character, Humanoid =
		WaitForAliveCharacter()

	if not Character
		or not Humanoid then

		return false, "정지"
	end

	local StartCharacter = Character
	local EndTime = os.clock() + Seconds

	while Running and RuntimeState.Working do
		if Player.Character ~= StartCharacter then
			return false, "사망"
		end

		if not Humanoid.Parent
			or Humanoid.Health <= 0 then

			return false, "사망"
		end

		local Left =
			EndTime - os.clock()

		if Left <= 0 then
			RuntimeState.RemainingTime = 0
			return true, "완료"
		end

		RuntimeState.RemainingTime =
			math.ceil(Left)

		RuntimeState.StateText =
			PointName
			.. " 점령 중, "
			.. FormatCountdown(Left)

		task.wait(0.2)
	end

	RuntimeState.RemainingTime = 0

	return false, "정지"
end

local function RunCapturePoint(
	PointName,
	Target,
	WaitTime
)
	local Attempt = 0

	while Running and RuntimeState.Working do
		Attempt = Attempt + 1

		local Character, Humanoid =
			WaitForAliveCharacter()

		if not Character
			or not Humanoid then

			return false
		end

		RuntimeState.StateText =
			PointName
			.. " 이동 중, "
			.. tostring(Attempt)
			.. "회 시도"

		local Moved =
			FlyToCapturePoint(
				Target,
				CAPTURE_MOVE_SPEED,
				true
			)

		if not RuntimeState.Working then
			return false
		end

		local CurrentCharacter =
			Player.Character

		local CurrentHumanoid =
			CurrentCharacter
			and CurrentCharacter:FindFirstChildOfClass(
				"Humanoid"
			)

		if not Moved
			or not CurrentHumanoid
			or CurrentHumanoid.Health <= 0 then

			RuntimeState.StateText =
				PointName
				.. " 이동 중 사망, 리스폰 후 재시도"

			WaitForAliveCharacter()
			task.wait(1)
			continue
		end

		StopCaptureMovement()

		local Captured, Reason =
			WaitCaptureAlive(
				WaitTime,
				PointName
			)

		if Captured then
			RuntimeState.StateText =
				PointName
				.. " 완료"

			return true
		end

		if Reason == "사망" then
			RuntimeState.StateText =
				PointName
				.. " 점령 중 사망, 리스폰 후 재시도"

			WaitForAliveCharacter()
			task.wait(1)
		else
			return false
		end
	end

	return false
end

-- 이 함수는 전역으로 둡니다.
-- 이유: 이 스크립트는 기능이 많아 Luau의 한 청크 로컬 변수 한도 200개에 도달했습니다.
-- StartWork를 로컬로 추가하면 컴파일 단계에서 UI가 뜨기 전에 스크립트가 멈춥니다.
local function StartWork()
	if RuntimeState.Working then
		return
	end

	if RuntimeState.SpinBusy then
		RuntimeState.StateText = "스핀 처리 중"
		return
	end

	if not RuntimeState.BaseSaved then
		if not SaveBasePoint() then
			RuntimeState.StateText = "기지 저장 실패"
			return
		end
	end

	RuntimeState.Working = true
	RuntimeState.IdleStart = nil
	RuntimeState.RemainingTime = 0

	RuntimeState.StateText = "점령 준비"

	SetGameUIVisible(true)
	SetRendering(false)

	task.spawn(function()
		StopCaptureMovement()

		local Point1Done =
			RunCapturePoint(
				"점령 1",
				Settings.POINT_1,
				Settings.POINT1_WAIT_TIME
			)

		if not Point1Done then
			if RuntimeState.Working then
				RuntimeState.StateText = "점령 1 실패"
			else
				RuntimeState.StateText = "사용자 정지"
			end

			RuntimeState.Working = false
			RuntimeState.RemainingTime = 0
			return
		end

		local Point2Done =
			RunCapturePoint(
				"점령 2",
				Settings.POINT_2,
				Settings.POINT2_WAIT_TIME
			)

		if not Point2Done then
			if RuntimeState.Working then
				RuntimeState.StateText = "점령 2 실패"
			else
				RuntimeState.StateText = "사용자 정지"
			end

			RuntimeState.Working = false
			RuntimeState.RemainingTime = 0
			return
		end

		if RuntimeState.AutoReturnBase
			and RuntimeState.BaseSaved
			and RuntimeState.BasePoint then

			local Returned = false
			local ReturnAttempt = 0

			while Running
				and RuntimeState.Working
				and not Returned do

				ReturnAttempt =
					ReturnAttempt + 1

				RuntimeState.StateText =
					"기지 복귀 "
					.. tostring(ReturnAttempt)
					.. "회 시도"

				Returned =
					ReturnToBaseVerified()

				if not Returned then
					RuntimeState.StateText =
						"기지 복귀 실패, 3초 후 재시도"

					task.wait(3)
				end
			end

			if not Running
				or not RuntimeState.Working then

				RuntimeState.StateText = "사용자 정지"
				RuntimeState.Working = false
				return
			end

			RuntimeState.StateText = "기지 복귀 완료"

			RefreshDiamondsAfterReturn()

			task.wait(
				Settings.RETURN_DIAMOND_REFRESH_DELAY
			)
		end

		if RuntimeState.AFKEnabled then
			if RuntimeState.FarmRecoveryPending and type(RuntimeState.BeginFarmRecovery) == "function" then
				RuntimeState.Working, RuntimeState.RemainingTime = false, 0
				RuntimeState.StateText = "점령 완료 · AFK 수입 건너뜀 · 자동팜 복구 중"
				RuntimeState.BeginFarmRecovery()
				return
			end
			RuntimeState.StateText =
				"기지 복귀 완료, AFK 이동"

			SetGameUIVisible(true)
			SetRendering(false)

			local AFKStarted =
				MoveToAFK()

			if AFKStarted then
				ApplyFPSCap(Settings.FPS_CAP)
				SetFPSLimitEnabled(true)

				RuntimeState.StateText =
					"AFK 정상 작동중, FPS "
					.. tostring(Settings.FPS_CAP)
			else
				SetFPSLimitEnabled(false)
			end
		end

		RuntimeState.Working = false
		RuntimeState.RemainingTime = 0
		RuntimeState.IdleStart = os.clock()

		Revenue.StartTime = RuntimeState.IdleStart
		Revenue.StartDiamonds = RuntimeState.CurrentDiamonds

		RuntimeState.StateText = "점령 완료, 방치"

		if IsAFKActive() then
			SetGameUIVisible(true)
		else
			SetGameUIVisible(false)
		end
	end)
end

-- 클랜 서버로 확인된 경우 자동으로 점령을 시작합니다.
-- 일반 서버와 클랜 없는 계정에서는 Requested가 false라 실행되지 않습니다.
task.spawn(function()
	while Running
		and not ClanCaptureAutoStart.Started do

		if ClanCaptureAutoStart.Requested then
			ClanCaptureAutoStart.Started = true

			RuntimeState.StateText =
				"클랜 서버 확인, 점령 자동 시작"

			task.wait(3)

			if Running
				and not RuntimeState.Working then

				StartWork()
			end

			break
		end

		task.wait(0.25)
	end
end)

AddConnection(
	UI.StartButton.MouseButton1Click:Connect(function()
		StartWork()
	end)
)

AddConnection(
	UI.StopButton.MouseButton1Click:Connect(function()
		RuntimeState.Working = false
		RuntimeState.RemainingTime = 0

		StopCaptureMovement()

		RuntimeState.StateText = "즉시 정지 완료"
	end)
)

AddConnection(
	UI.Point1Button.MouseButton1Click:Connect(function()
		if RuntimeState.Working or RuntimeState.SpinBusy then
			return
		end

		StopCaptureMovement()

		RuntimeState.StateText = "점령 1 수동 이동 중, 속도 " .. tostring(math.floor(CAPTURE_MOVE_SPEED)) .. ", 걷는 동작"

		task.spawn(function()
			if FlyToCapturePoint(
				Settings.POINT_1,
				CAPTURE_MOVE_SPEED,
				false
			) then

				RuntimeState.StateText = "점령 1 도착"
			else
				RuntimeState.StateText = "점령 1 이동 실패"
			end
		end)
	end)
)

AddConnection(
	UI.Point2Button.MouseButton1Click:Connect(function()
		if RuntimeState.Working or RuntimeState.SpinBusy then
			return
		end

		StopCaptureMovement()

		RuntimeState.StateText = "점령 2 수동 이동 중, 속도 " .. tostring(math.floor(CAPTURE_MOVE_SPEED)) .. ", 걷는 동작"

		task.spawn(function()
			if FlyToCapturePoint(
				Settings.POINT_2,
				CAPTURE_MOVE_SPEED,
				false
			) then

				RuntimeState.StateText = "점령 2 도착"
			else
				RuntimeState.StateText = "점령 2 이동 실패"
			end
		end)
	end)
)

AddConnection(
	UI.SaveBaseButton.MouseButton1Click:Connect(function()
		if SaveBasePoint() then
			RuntimeState.StateText = "기지 저장 완료"
			UpdateDiamonds()
		else
			RuntimeState.StateText = "기지 저장 실패"
		end
	end)
)

AddConnection(
	UI.BaseButton.MouseButton1Click:Connect(function()
		if RuntimeState.Working
			or RuntimeState.SpinBusy
			or not RuntimeState.BaseSaved
			or not RuntimeState.BasePoint then

			return
		end

		RuntimeState.StateText = "자기기지 이동"

		Teleport(RuntimeState.BasePoint)
		RefreshDiamondsAfterReturn()
	end)
)

AddConnection(
	UI.AFKButton.MouseButton1Click:Connect(function()
		RuntimeState.AFKEnabled = not RuntimeState.AFKEnabled
	end)
)

AddConnection(
	UI.RenderButton.MouseButton1Click:Connect(function()
		SetRendering(
			not RuntimeState.RenderingEnabled
		)
	end)
)

AddConnection(
	UI.GameUIButton.MouseButton1Click:Connect(function()
		SetGameUIVisible(
			not RuntimeState.GameUIVisible
		)
	end)
)

AddConnection(
	UI.ReturnButton.MouseButton1Click:Connect(function()
		RuntimeState.AutoReturnBase = not RuntimeState.AutoReturnBase
	end)
)

AddConnection(
	UI.AutoGameUIOffButton.MouseButton1Click:Connect(function()
		RuntimeState.AutoGameUIOff60 = not RuntimeState.AutoGameUIOff60
	end)
)

AddConnection(
	UI.ResetProfitButton.MouseButton1Click:Connect(function()
		UpdateDiamonds()

		if RuntimeState.CurrentDiamonds then
			RuntimeState.StartDiamonds = RuntimeState.CurrentDiamonds
			RuntimeState.LastDiamondValue = RuntimeState.CurrentDiamonds
			RuntimeState.DiamondProfit = 0
			RuntimeState.LastDiamondChange = 0
			RuntimeState.LastDiamondChangeTime = "초기화"
			RuntimeState.DiamondStartCandidate = RuntimeState.CurrentDiamonds
			RuntimeState.DiamondStartCandidateCount =
				Settings.DIAMOND_START_CONFIRM_COUNT
		end
	end)
)


AddConnection(
	UI.MoveSpeedButton.MouseButton1Click:Connect(function()
		UI.DefaultSpeedBox.Text =
			tostring(
				math.floor(
					CAPTURE_MOVE_DEFAULT
				)
			)

		UI.SpeedPopup.Visible = true
	end)
)

AddConnection(
	UI.SpeedMinusButton.MouseButton1Click:Connect(function()
		CAPTURE_MOVE_SPEED =
			math.max(
				Settings.MOVE_SPEED_MIN,
				CAPTURE_MOVE_SPEED - 10
			)

		RuntimeState.StateText =
			"이동 속도 "
			.. tostring(
				math.floor(
					CAPTURE_MOVE_SPEED
				)
			)
	end)
)

AddConnection(
	UI.SpeedPlusButton.MouseButton1Click:Connect(function()
		CAPTURE_MOVE_SPEED =
			math.min(
				Settings.MOVE_SPEED_MAX,
				CAPTURE_MOVE_SPEED + 10
			)

		RuntimeState.StateText =
			"이동 속도 "
			.. tostring(
				math.floor(
					CAPTURE_MOVE_SPEED
				)
			)
	end)
)

AddConnection(
	UI.SaveDefaultSpeedButton.MouseButton1Click:Connect(function()
		local Value =
			tonumber(
				UI.DefaultSpeedBox.Text
			)

		if not Value then
			RuntimeState.StateText =
				"기본 속도 숫자를 입력하세요."
			return
		end

		Value =
			math.clamp(
				math.floor(Value),
				Settings.MOVE_SPEED_MIN,
				Settings.MOVE_SPEED_MAX
			)

		CAPTURE_MOVE_DEFAULT = Value
		CAPTURE_MOVE_SPEED = Value
		UI.DefaultSpeedBox.Text =
			tostring(Value)

		if typeof(writefile) == "function" then
			local Saved =
				pcall(function()
					writefile(
						Settings.MOVE_SPEED_DEFAULT_FILE,
						tostring(Value)
					)
				end)

			if Saved then
				RuntimeState.StateText =
					"기본 이동 속도 "
					.. tostring(Value)
					.. " 저장 완료"
			else
				RuntimeState.StateText =
					"기본값 저장 실패, 현재 실행에는 적용됨"
			end
		else
			RuntimeState.StateText =
				"파일 저장 기능 없음, 현재 실행에는 적용됨"
		end
	end)
)

AddConnection(
	UI.ApplyDefaultSpeedButton.MouseButton1Click:Connect(function()
		CAPTURE_MOVE_SPEED =
			CAPTURE_MOVE_DEFAULT

		RuntimeState.StateText =
			"기본 이동 속도 "
			.. tostring(
				math.floor(
					CAPTURE_MOVE_DEFAULT
				)
			)
			.. " 적용"
	end)
)

AddConnection(
	UI.SpeedCloseButton.MouseButton1Click:Connect(function()
		UI.SpeedPopup.Visible = false
	end)
)


AddConnection(
	UI.FPSButton.MouseButton1Click:Connect(function()
		UI.FPSBox.Text =
			tostring(Settings.FPS_CAP)

		UI.FPSPopup.Visible = true
	end)
)

AddConnection(
	UI.FPSClose.MouseButton1Click:Connect(function()
		UI.FPSPopup.Visible = false
	end)
)

AddConnection(
	UI.FPSToggle.MouseButton1Click:Connect(function()
		SetFPSLimitEnabled(
			not FPS_ENABLED
		)
	end)
)

AddConnection(
	UI.FPS5.MouseButton1Click:Connect(function()
		ApplyFPSCap(5)

		if IsAFKActive() then
			SetFPSLimitEnabled(true)
		end
	end)
)

AddConnection(
	UI.FPS15.MouseButton1Click:Connect(function()
		ApplyFPSCap(15)

		if IsAFKActive() then
			SetFPSLimitEnabled(true)
		end
	end)
)

AddConnection(
	UI.FPS30.MouseButton1Click:Connect(function()
		ApplyFPSCap(30)

		if IsAFKActive() then
			SetFPSLimitEnabled(true)
		end
	end)
)

AddConnection(
	UI.FPSApply.MouseButton1Click:Connect(function()
		local Value =
			tonumber(
				UI.FPSBox.Text
			)

		if Value then
			ApplyFPSCap(Value)

			if IsAFKActive() then
				SetFPSLimitEnabled(true)
			end

			UI.FPSBox.Text =
				tostring(Settings.FPS_CAP)
		end
	end)
)

AddConnection(
	UI.AutoSpinButton.MouseButton1Click:Connect(function()
		RuntimeState.AutoSpinEnabled =
			not RuntimeState.AutoSpinEnabled

		if RuntimeState.AutoSpinEnabled then
			RuntimeState.NextSpinAt = nil
			RuntimeState.SpinStatus = "자동 확인 대기"
		else
			RuntimeState.SpinStatus = "자동 스핀 꺼짐"
		end
	end)
)

AddConnection(
	UI.TestSpinButton.MouseButton1Click:Connect(function()
		if not RuntimeState.SpinBusy and not RuntimeState.Working then
			task.spawn(RunFreeSpin)
		end
	end)
)

AddConnection(
	UI.WorkTab.MouseButton1Click:Connect(function()
		ShowPage("작업")
	end)
)

AddConnection(
	UI.MoveTab.MouseButton1Click:Connect(function()
		ShowPage("이동")
	end)
)

AddConnection(
	UI.SettingsTab.MouseButton1Click:Connect(function()
		ShowPage("설정")
	end)
)

AddConnection(
	UI.SpinTab.MouseButton1Click:Connect(function()
		ShowPage("스핀")
	end)
)

AddConnection(
	PlayerGui.ChildAdded:Connect(function(Object)
		if not RuntimeState.GameUIVisible then
			task.defer(function()
				if Running
					and Object.Parent then

					HideOneGameGui(Object)
				end
			end)
		end
	end)
)

local function SendAFKIdleInput()
	if not Running
		or not Settings.AFK_IDLE_PREVENT_ENABLED then

		return false
	end

	-- 채팅이나 숫자 입력 중에는 Z가 글자로 들어가지 않게 잠시 미룹니다.
	if UserInputService:GetFocusedTextBox() then
		return false
	end

	-- 게임에서 사용하지 않는 Z키를 짧게 눌렀다 떼어 실제 입력으로 인식시킵니다.
	-- 자동팜, AFK 패드, 일반 대기 모두 같은 함수와 같은 5분 주기를 사용합니다.
	local Success =
		pcall(function()
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
			task.wait(0.08)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
		end)

	if Success then
		RuntimeState.AFKCount = RuntimeState.AFKCount + 1
		RuntimeState.LastAFKTime = os.date("%H:%M:%S")
	end

	return Success
end

AddConnection(
	Player.Idled:Connect(function()
		-- 5분 예방 입력이 실행기에서 무시된 경우를 위한 즉시 보조 안전장치입니다.
		-- 성공 여부와 관계없이 다음 정기 시각을 다시 잡아 연속 중복 입력을 막습니다.
		local Sent = SendAFKIdleInput()
		RuntimeState.AFKNextIdleInputAt =
			os.clock()
			+ (Sent and Settings.AFK_IDLE_PREVENT_INTERVAL or 15)
	end)
)

task.spawn(function()
	while Running do
		-- AFK 패드 보상 수집은 기존 조건과 주기를 그대로 유지합니다.
		if RuntimeState.AFKEnabled
			and IsAFKActive()
			and not RuntimeState.Working then

			if not RuntimeState.AFKInitialCollectDone then
				TryCollectAFKRewards()

				RuntimeState.AFKInitialCollectDone = true
				RuntimeState.AFKNextCollectAt =
					os.clock()
					+ Settings.AFK_COLLECT_INTERVAL

			elseif RuntimeState.AFKNextCollectAt
				and os.clock() >= RuntimeState.AFKNextCollectAt then

				TryCollectAFKRewards()

				RuntimeState.AFKNextCollectAt =
					os.clock()
					+ Settings.AFK_COLLECT_INTERVAL
			end
		else
			RuntimeState.AFKInitialCollectDone = false
			RuntimeState.AFKNextCollectAt = nil
		end

		-- 자리비움 방지는 AFK 패드 여부나 자동팜 운용 여부와 무관하게 상시 작동합니다.
		-- 이 한 곳에서만 5분 주기를 예약하여 별도 반복문과 중복 입력을 만들지 않습니다.
		if Settings.AFK_IDLE_PREVENT_ENABLED then
			if not RuntimeState.AFKNextIdleInputAt then
				RuntimeState.AFKNextIdleInputAt =
					os.clock()
					+ Settings.AFK_IDLE_PREVENT_INTERVAL

			elseif os.clock() >= RuntimeState.AFKNextIdleInputAt then
				local Sent = SendAFKIdleInput()

				RuntimeState.AFKNextIdleInputAt =
					os.clock()
					+ (Sent and Settings.AFK_IDLE_PREVENT_INTERVAL or 15)
			end
		else
			RuntimeState.AFKNextIdleInputAt = nil
		end

		task.wait(5)
	end
end)

task.spawn(function()
	while Running do
		UpdateDiamonds()
		task.wait(0.5)
	end
end)

task.spawn(function()
	while Running do
		if RuntimeState.AutoSpinEnabled
			and not RuntimeState.SpinBusy then
			SyncHeadlessSpinTimer()
		end
		task.wait(5)
	end
end)

task.spawn(function()
	while Running do
		if RuntimeState.AutoSpinEnabled
			and not RuntimeState.SpinBusy
			and not RuntimeState.Working
			and not RuntimeState.AFKRewardState.Busy
			and (RuntimeState.NextSpinAt == nil or os.clock() >= RuntimeState.NextSpinAt) then
			task.spawn(RunFreeSpin)
			task.wait(5)
		end

		task.wait(1)
	end
end)

task.spawn(function()
	while Running do
		if RuntimeState.GuiVisible then
			Refresh()
		end

		task.wait(0.2)
	end
end)

UI.Dragging = false
UI.DragStart = nil
UI.StartPosition = nil

AddConnection(
	UI.Title.InputBegan:Connect(function(Input)
		if Input.UserInputType
			== Enum.UserInputType.MouseButton1 then

			UI.Dragging = true
			UI.DragStart = Input.Position
			UI.StartPosition = UI.Main.Position
		end
	end)
)

AddConnection(
	UserInputService.InputChanged:Connect(function(Input)
		if not UI.Dragging then
			return
		end

		if Input.UserInputType
			~= Enum.UserInputType.MouseMovement then

			return
		end

		local Delta =
			Input.Position - UI.DragStart

		UI.Main.Position =
			UDim2.new(
				UI.StartPosition.X.Scale,
				UI.StartPosition.X.Offset + Delta.X,
				UI.StartPosition.Y.Scale,
				UI.StartPosition.Y.Offset + Delta.Y
			)
	end)
)

AddConnection(
	UserInputService.InputEnded:Connect(function(Input)
		if Input.UserInputType
			== Enum.UserInputType.MouseButton1 then

			UI.Dragging = false
		end
	end)
)

task.spawn(function()
	while Running do
		task.wait(60)

		if Running
			and RuntimeState.AutoGameUIOff60
			and ServerDisplayState == "클랜서버" then

			SetGameUIVisible(false)
		end
	end
end)

AddConnection(
	UI.MinimizeButton.MouseButton1Click:Connect(function()
		UI.SetCompactMode(not UI.CompactMode)
	end)
)

AddConnection(
	UI.CompactQuickButton.MouseButton1Click:Connect(function()
		UI.QuickPopup.Visible = true
		UI.QuickPopup.Position =
			UDim2.new(
				0.5,
				-115,
				0.5,
				-122
			)
	end)
)

AddConnection(
	UI.QuickClose.MouseButton1Click:Connect(function()
		UI.QuickPopup.Visible = false
	end)
)

AddConnection(
	UI.QuickX.MouseButton1Click:Connect(function()
		UI.QuickPopup.Visible = false
	end)
)

AddConnection(
	UI.QuickStart.MouseButton1Click:Connect(function()
		UI.QuickPopup.Visible = false
		StartWork()
	end)
)

AddConnection(
	UI.QuickStop.MouseButton1Click:Connect(function()
		UI.QuickPopup.Visible = false
		RuntimeState.Working = false
		RuntimeState.RemainingTime = 0
		StopCaptureMovement()
		RuntimeState.StateText = "즉시 정지 완료"
	end)
)

AddConnection(
	UI.QuickPoint1.MouseButton1Click:Connect(function()
		UI.QuickPopup.Visible = false
		if RuntimeState.Working or RuntimeState.SpinBusy then return end
		StopCaptureMovement()
		RuntimeState.StateText = "점령 1 수동 이동 중"
		task.spawn(function()
			if FlyToCapturePoint(Settings.POINT_1, CAPTURE_MOVE_SPEED, false) then
				RuntimeState.StateText = "점령 1 도착"
			else
				RuntimeState.StateText = "점령 1 이동 실패"
			end
		end)
	end)
)

AddConnection(
	UI.QuickPoint2.MouseButton1Click:Connect(function()
		UI.QuickPopup.Visible = false
		if RuntimeState.Working or RuntimeState.SpinBusy then return end
		StopCaptureMovement()
		RuntimeState.StateText = "점령 2 수동 이동 중"
		task.spawn(function()
			if FlyToCapturePoint(Settings.POINT_2, CAPTURE_MOVE_SPEED, false) then
				RuntimeState.StateText = "점령 2 도착"
			else
				RuntimeState.StateText = "점령 2 이동 실패"
			end
		end)
	end)
)

AddConnection(
	UI.QuickBase.MouseButton1Click:Connect(function()
		UI.QuickPopup.Visible = false
		if RuntimeState.Working or RuntimeState.SpinBusy or not RuntimeState.BaseSaved or not RuntimeState.BasePoint then return end
		RuntimeState.StateText = "자기기지 이동"
		Teleport(RuntimeState.BasePoint)
		RefreshDiamondsAfterReturn()
	end)
)

AddConnection(
	UI.CompactExpandButton.MouseButton1Click:Connect(function()
		UI.SetCompactMode(false)
	end)
)

AddConnection(
	UI.CompactCombinedButton.MouseButton1Click:Connect(function()
		local BothOn =
			RuntimeState.RenderingEnabled
			and RuntimeState.GameUIVisible

		local Target =
			not BothOn

		SetRendering(Target)
		SetGameUIVisible(Target)
	end)
)

AddConnection(
	UI.CloseButton.MouseButton1Click:Connect(function()
		if not Running then
			return
		end

		local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
		if Bridge and type(Bridge.RequestAllStopConfirm) == "function" then
			Bridge.RequestAllStopConfirm()
			return
		end

		Running = false
		RuntimeState.Working = false
		RuntimeState.AutoSpinEnabled = false
		AutoButtonRunning = false

		StopCaptureMovement()

		SetGameUIVisible(true)
		SetRendering(true)
		SetFPSLimitEnabled(false)

		for _, Connection in ipairs(Connections) do
			if Connection
				and Connection.Connected then

				Connection:Disconnect()
			end
		end

		table.clear(Connections)

		if UI.Gui and UI.Gui.Parent then
			UI.Gui:Destroy()
		end
	end)
)

task.wait(0.5)

SaveBasePoint()
UpdateDiamonds()

SetGameUIVisible(true)
SetRendering(true)

ShowPage("작업")

-- 다클라용 기본 작은 창
UI.SetCompactMode(true)
Refresh()

-- ============================================================
-- 쇼타임 통합 자동팜 V1.0 시험 연결부
-- 점령·스핀·AFK를 메인으로 유지하고 자동팜은 버튼을 눌렀을 때만 불러옵니다.
-- 자동팜 V1.3의 좌클릭 속도·F·차량 대기열·아군 F35 제외 코드는 유지합니다.
-- ============================================================

-- IntegratedBridge는 복구 상태를 점령 흐름에서도 사용하도록 바깥에서 먼저 선언했습니다.

local FARM_SOURCE = [====[
-- 쇼타임 자동 팜 V1.3 정식 기준본
-- V1.2 정식 기준본에 HighlightIsFriendly 기반 아군 NPC F35 제외를 추가한 정식판입니다.
-- 실게임 검증 완료: 아군 true는 공격하지 않고 적군 false는 정상 공격합니다.
-- 이후 기능 변경은 이 파일을 직접 덮어쓰지 않고 별도 시험 버전에서 진행합니다.
-- 좌클릭 속도·F·경로·차량 대기열·레벨 알림은 V1.2에서 변경하지 않았습니다.
-- 실게임 검증 완료: 계정별 대기열 저장·불러오기, 차량별 목표 수정, 자동 다음 차량 소환 정상.
-- 실게임 검증 완료: 목표 달성 정지·하차, 디스코드 알림, 시작 레벨→완료 레벨 표시 정상.
-- 이후 기능 변경은 이 파일을 직접 덮어쓰지 않고 별도 시험 버전에서 진행합니다.
-- 현재 차량은 직접 시작하고 다음 차량부터 목표 레벨과 함께 대기열에 등록합니다.
-- 목표 기본값은 100이며 등록 후 목표 수정·순서 변경·삭제가 가능합니다.
-- 차량별 첫 소환 실패만 디스코드로 알리고 5초마다 같은 차량을 재시도합니다.
-- 차량별 완료 시간과 전체 완료 요약을 디스코드로 전송합니다.
-- 디스코드 완료 메시지에 시작 시각·달성 시각·걸린 시간·재소환 횟수를 표시합니다.
-- 웹훅은 실행기 파일 API 지원 시 로컬 설정 파일에 저장하고 다음 실행 때 자동으로 불러옵니다.
-- 캡처 기능은 사용하지 않으며, 전송 시험 버튼으로 실행기 외부 요청 지원 여부를 확인합니다.
-- 이후 기능 변경은 이 파일을 직접 덮어쓰지 않고 별도 버전에서 진행합니다.
-- 경로 이동 기본값: 켜짐 / 높이 Y=1000 / 속도 200 / 12개 좌표 반복.
-- 소환·재소환 때마다 현재 차량 위치에서 가장 가까운 경로점부터 시작합니다.
-- 지상·공중·해상 차량 모두 같은 공중 경로를 사용하며 이동 중 충돌을 끕니다.
-- 정지하면 경로 이동을 멈추고 변경했던 충돌 속성을 복원합니다.
-- 좌클릭 발사 속도와 F 자동사용 흐름은 V2.5에서 변경하지 않았습니다.
-- 강제하차 5초 자동복구·재소환 통계 + 공통 자동파밍 기준본 V2.5
-- 차량 선택 후 '파밍 시작'을 누르면 선택 UUID로 차량을 소환합니다.
-- 탑승은 게임의 기존 자동 탑승 기능을 사용합니다.
-- 이미 차량에 탑승 중이면 자동 하차 완료 후 새 차량을 소환합니다.
-- 변경 요약
-- getgc 1회만 실행
-- 메모리 전체 순회 1회로 축소
-- UI 먼저 생성 후 차량 데이터 탐색
-- UUID에 연결된 차량 레코드가 여러 개면 가장 높은 Level 사용
-- VehicleId 존재 항목만 실제 차량으로 인정
-- 병사, 방어구, 유니폼 제외
-- UUID 중복 제거
-- 지상, 공중, 해군 분리
-- 이미지, 레벨, 별 표시
-- QN506 Level 18 오선택 수정 목표
-- 차량 변경 시 기존 자동공격을 정지하고 새 차량 탑승 후 다시 시작합니다.
-- 추적 차량이 제거되면 마지막 선택 UUID로 자동 재소환합니다.
-- 보유차량 선택창은 기본으로 숨기고 버튼을 누를 때만 팝업으로 표시합니다.
-- 선택 차량 파밍 시작을 누르면 팝업을 닫고 메인 자동공격 화면으로 자동 복귀합니다.
-- 실전 검증 완료: 강제하차·점프 후 5초 자동 재소환, 자동 탑승·공격 재개, 재소환 통계 정상.
-- 동적 차량 행이 배경 뒤로 숨는 ZIndex 문제를 제거했습니다.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local OLD = PlayerGui:FindFirstChild("VehiclePickerSpawnAttackV19")
    or PlayerGui:FindFirstChild("VehiclePickerSpawnV12")
    or PlayerGui:FindFirstChild("VehiclePickerSpawnV11")
if OLD then
    OLD:Destroy()
end

local StartIntegratedAttack
local StopIntegratedAttack
local CloseIntegratedAttack
local OpenVehiclePopup
local CloseIntegratedApplication
local SetAttackPanelVisible
local UpdateSelectedVehicleCard
local UpdateRespawnCount
local SetVehicleWatchdogEnabled
local GetSelectedVehicleSnapshot
local ApplyVehicleGoalLevel
local UpdateVehicleGoalDisplay
local OnVehicleGoalCompleted
local SendQueueSpawnFailure
local SendQueueAllComplete
local IntegratedHost
local SaveFarmRecoveryDirect
local Config
local CaptureAttackSettings
local ApplyAttackSettings
local OpenQueueAttackSettings

local State = {
    CurrentTab = "All",
    Selected = nil,
    Loading = false,
    Spawning = false,
    Farming = false,
    AutoRespawn = true,
    ActiveVehicle = nil,
    LastRespawnAttempt = 0,
    KeepRunning = false,
    UnseatedSince = nil,
    RespawnCount = 0,
    ActiveFarmData = nil,
    RecoveryFarmData = nil,
    FarmInitialLevel = nil,
    CurrentView = "Vehicles",
    QueueSelectedIndex = nil,
    QueueTransition = false,
    SearchText = "",
    SortMode = "LevelAsc",
    LastInventoryScanAt = 0,
    LastInventoryCount = 0,
    InventoryBootstrapAttempted = false,
    InventoryBootstrapRunning = false,
    InventoryBootstrapSucceeded = false,

    Owned = {
        All = {},
        Land = {},
        Air = {},
        Naval = {}
    },

    Images = {},
    VehicleTypes = {},
    VehicleRarity = {},
    RarityColors = {
        Common = Color3.fromRGB(42, 44, 50),
        Uncommon = Color3.fromRGB(38, 64, 48),
        Rare = Color3.fromRGB(38, 56, 82),
        Epic = Color3.fromRGB(65, 43, 86),
        Legendary = Color3.fromRGB(88, 66, 30),
        Exotic = Color3.fromRGB(82, 42, 62),
        Limited = Color3.fromRGB(130, 38, 45),
    },
    UUIDRecords = {},
    UUIDLinks = {},
    VehicleRecords = {}
}

local Queue = {
    Entries = {},
    Completed = {},
    SessionActive = false,
    SessionStartedUnix = nil,
    TotalRespawns = 0,
    CurrentTransition = nil,
    FailureNotified = {},
    SuppressRecoverySync = false,
    ConfigFile = "showtime_vehicle_queue_v1_" .. tostring(Player.UserId) .. ".json",
}

local CategoryName = {
    All = "전체",
    Land = "지상",
    Air = "공중",
    Naval = "해상"
}

local function lower(v)
    return string.lower(tostring(v or ""))
end

local function parseGoalLevel(value)
    local text = tostring(value == nil and "" or value):match("^%s*(.-)%s*$")
    if text == "" then
        return nil, "목표 레벨을 입력하세요 · 0은 무제한, 1~100은 목표 레벨입니다"
    end

    local number = tonumber(text)
    if not number or number < 0 then
        return nil, "목표 레벨은 0부터 100 사이의 숫자만 사용할 수 있습니다"
    end

    return math.clamp(math.floor(number), 0, 100), nil
end

local function goalLevelText(value)
    return tonumber(value) == 0 and "무제한" or tostring(math.floor(tonumber(value) or 100))
end

local function normalizeRarity(value)
    local text = lower(value):gsub("[%s_%-]+", "")
    local aliases = {
        common = "Common",
        uncommon = "Uncommon",
        rare = "Rare",
        epic = "Epic",
        legendary = "Legendary",
        exotic = "Exotic",
        limited = "Limited",
        limitededition = "Limited",
        exclusive = "Limited",
        event = "Limited",
        ["한정"] = "Limited",
        ["한정판"] = "Limited",
    }
    return aliases[text] or (value and tostring(value)) or nil
end

local function safeRaw(tbl, key)
    local value

    pcall(function()
        value = rawget(tbl, key)
    end)

    return value
end

local function isUUID(v)
    if type(v) ~= "string" then
        return false
    end

    return v:match(
        "^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$"
    ) ~= nil
end

local function isVehicleRecord(tbl)
    if type(tbl) ~= "table" then
        return false
    end

    local vehicleId = safeRaw(tbl, "VehicleId")

    return type(vehicleId) == "string"
        and vehicleId ~= ""
end

local function parseCategory(value)
    local t = lower(value)

    if t == "" then
        return nil
    end

    if t:find("air", 1, true)
    or t:find("aircraft", 1, true)
    or t:find("plane", 1, true)
    or t:find("jet", 1, true)
    or t:find("helicopter", 1, true) then
        return "Air"
    end

    if t:find("naval", 1, true)
    or t:find("boat", 1, true)
    or t:find("ship", 1, true)
    or t:find("water", 1, true)
    or t:find("sea", 1, true)
    or t:find("submarine", 1, true) then
        return "Naval"
    end

    if t:find("land", 1, true)
    or t:find("ground", 1, true)
    or t:find("tank", 1, true)
    or t:find("truck", 1, true)
    or t:find("car", 1, true)
    or t:find("jeep", 1, true) then
        return "Land"
    end

    return nil
end

local function fallbackCategory(name)
    local t = lower(name)

    local airWords = {
        "f16",
        "f15",
        "f18",
        "f22",
        "f35",
        "f117",
        "raptor",
        "darkstar",
        "b29",
        "b-29",
        "b17",
        "b-17",
        "bomber",
        "jet",
        "plane",
        "helicopter",
        "heli",
        "blackhawk",
        "mig",
        "su27",
        "su-27",
        "a10",
        "a-10",
        "f4",
        "f-4",
        "f14",
        "f-14"
    }

    local navalWords = {
        "boat",
        "ship",
        "submarine",
        "destroyer",
        "carrier",
        "frigate",
        "yamato",
        "sachsen",
        "carolina",
        "sea dragon"
    }

    for _, word in ipairs(airWords) do
        if t:find(word, 1, true) then
            return "Air"
        end
    end

    for _, word in ipairs(navalWords) do
        if t:find(word, 1, true) then
            return "Naval"
        end
    end

    return "Land"
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "VehiclePickerSpawnAttackV24"
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

local Root = Instance.new("Frame")
Root.Size = UDim2.fromOffset(580, 450)
Root.Position = UDim2.new(0.5, -290, 0, 0)
Root.BackgroundTransparency = 1
Root.Active = true
Root.Draggable = true
Root.Parent = Gui
IntegratedHost = Root

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(500, 440)
Main.Position = UDim2.fromOffset(40, 2)
Main.BackgroundColor3 = Color3.fromRGB(23, 23, 28)
Main.BorderSizePixel = 0
Main.Active = false
Main.Draggable = false
Main.Parent = Root
Main.Visible = false

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -140, 0, 42)
Title.Position = UDim2.fromOffset(15, 5)
Title.BackgroundTransparency = 1
Title.Text = "보유차량 선택·소환"
Title.TextColor3 = Color3.fromRGB(245, 245, 245)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

local Refresh = Instance.new("TextButton")
Refresh.Size = UDim2.fromOffset(72, 30)
Refresh.Position = UDim2.new(1, -125, 0, 10)
Refresh.BackgroundColor3 = Color3.fromRGB(55, 55, 64)
Refresh.Text = "새로고침"
Refresh.TextColor3 = Color3.new(1, 1, 1)
Refresh.TextSize = 13
Refresh.Font = Enum.Font.GothamBold
Refresh.Parent = Main

local RefreshCorner = Instance.new("UICorner")
RefreshCorner.CornerRadius = UDim.new(0, 6)
RefreshCorner.Parent = Refresh

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(35, 30)
Close.Position = UDim2.new(1, -43, 0, 10)
Close.BackgroundColor3 = Color3.fromRGB(155, 48, 48)
Close.Text = "X"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.TextSize = 14
Close.Font = Enum.Font.GothamBold
Close.Parent = Main

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = Close

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -30, 0, 20)
Status.Position = UDim2.fromOffset(15, 48)
Status.BackgroundTransparency = 1
Status.Text = "차량 데이터 준비중"
Status.TextColor3 = Color3.fromRGB(180, 180, 188)
Status.TextSize = 13
Status.Font = Enum.Font.Gotham
Status.TextXAlignment = Enum.TextXAlignment.Left
Status.Parent = Main

local ViewTabs = Instance.new("Frame")
ViewTabs.Size = UDim2.new(1, -30, 0, 30)
ViewTabs.Position = UDim2.fromOffset(15, 72)
ViewTabs.BackgroundTransparency = 1
ViewTabs.Parent = Main

local VehicleViewButton = Instance.new("TextButton")
VehicleViewButton.Size = UDim2.new(0.5, -3, 1, 0)
VehicleViewButton.Position = UDim2.fromOffset(0, 0)
VehicleViewButton.BackgroundColor3 = Color3.fromRGB(62, 82, 118)
VehicleViewButton.BorderSizePixel = 0
VehicleViewButton.Text = "차량 선택"
VehicleViewButton.TextColor3 = Color3.new(1, 1, 1)
VehicleViewButton.TextSize = 14
VehicleViewButton.Font = Enum.Font.GothamBold
VehicleViewButton.Parent = ViewTabs

local QueueViewButton = Instance.new("TextButton")
QueueViewButton.Size = UDim2.new(0.5, -3, 1, 0)
QueueViewButton.Position = UDim2.new(0.5, 3, 0, 0)
QueueViewButton.BackgroundColor3 = Color3.fromRGB(46, 46, 53)
QueueViewButton.BorderSizePixel = 0
QueueViewButton.Text = "파밍 대기열 0"
QueueViewButton.TextColor3 = Color3.new(1, 1, 1)
QueueViewButton.TextSize = 14
QueueViewButton.Font = Enum.Font.GothamBold
QueueViewButton.Parent = ViewTabs

local Tabs = Instance.new("Frame")
Tabs.Size = UDim2.new(1, -30, 0, 28)
Tabs.Position = UDim2.fromOffset(15, 108)
Tabs.BackgroundTransparency = 1
Tabs.Parent = Main

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 6)
TabLayout.Parent = Tabs

local VehicleSearchBox = Instance.new("TextBox")
VehicleSearchBox.Size = UDim2.fromOffset(290, 24)
VehicleSearchBox.Position = UDim2.fromOffset(15, 140)
VehicleSearchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 37)
VehicleSearchBox.BorderSizePixel = 0
VehicleSearchBox.ClearTextOnFocus = false
VehicleSearchBox.PlaceholderText = "차량 이름 검색 · 예: A"
VehicleSearchBox.Text = ""
VehicleSearchBox.TextColor3 = Color3.fromRGB(245, 245, 245)
VehicleSearchBox.PlaceholderColor3 = Color3.fromRGB(145, 145, 155)
VehicleSearchBox.TextSize = 14
VehicleSearchBox.Font = Enum.Font.Gotham
VehicleSearchBox.TextXAlignment = Enum.TextXAlignment.Left
VehicleSearchBox.Parent = Main

local VehicleSearchPadding = Instance.new("UIPadding")
VehicleSearchPadding.PaddingLeft = UDim.new(0, 9)
VehicleSearchPadding.PaddingRight = UDim.new(0, 9)
VehicleSearchPadding.Parent = VehicleSearchBox

local VehicleSortButton = Instance.new("TextButton")
VehicleSortButton.Size = UDim2.fromOffset(170, 24)
VehicleSortButton.Position = UDim2.fromOffset(315, 140)
VehicleSortButton.BackgroundColor3 = Color3.fromRGB(58, 68, 92)
VehicleSortButton.BorderSizePixel = 0
VehicleSortButton.Text = "정렬: 낮은 레벨순"
VehicleSortButton.TextColor3 = Color3.fromRGB(245, 245, 245)
VehicleSortButton.TextSize = 13
VehicleSortButton.Font = Enum.Font.GothamBold
VehicleSortButton.Parent = Main

local VehicleSortCorner = Instance.new("UICorner")
VehicleSortCorner.CornerRadius = UDim.new(0, 5)
VehicleSortCorner.Parent = VehicleSortButton
VehicleSortButton.ZIndex = 42

local VehicleSortMenu = Instance.new("Frame")
VehicleSortMenu.Size = UDim2.fromOffset(170, 136)
VehicleSortMenu.Position = UDim2.fromOffset(315, 164)
VehicleSortMenu.BackgroundColor3 = Color3.fromRGB(29, 30, 37)
VehicleSortMenu.BorderSizePixel = 0
VehicleSortMenu.Visible = false
VehicleSortMenu.ZIndex = 40
VehicleSortMenu.Parent = Main

local VehicleSortMenuCorner = Instance.new("UICorner")
VehicleSortMenuCorner.CornerRadius = UDim.new(0, 6)
VehicleSortMenuCorner.Parent = VehicleSortMenu

local VehicleSortMenuStroke = Instance.new("UIStroke")
VehicleSortMenuStroke.Color = Color3.fromRGB(74, 78, 92)
VehicleSortMenuStroke.Thickness = 1
VehicleSortMenuStroke.Parent = VehicleSortMenu

local VehicleSortOptions = {
    { Mode = "LevelAsc", Label = "낮은 레벨순" },
    { Mode = "LevelDesc", Label = "높은 레벨순" },
    { Mode = "StarAsc", Label = "별 개수 낮은순" },
    { Mode = "StarDesc", Label = "별 개수 높은순" },
    { Mode = "NameAsc", Label = "이름순" },
}

for index, option in ipairs(VehicleSortOptions) do
    local optionButton = Instance.new("TextButton")
    optionButton.Name = option.Mode
    optionButton.Size = UDim2.new(1, -8, 0, 23)
    optionButton.Position = UDim2.fromOffset(4, 4 + ((index - 1) * 26))
    optionButton.BackgroundColor3 = Color3.fromRGB(45, 47, 57)
    optionButton.BorderSizePixel = 0
    optionButton.Text = option.Label
    optionButton.TextColor3 = Color3.fromRGB(235, 235, 240)
    optionButton.TextSize = 12
    optionButton.Font = Enum.Font.Gotham
    optionButton.ZIndex = 41
    optionButton.Parent = VehicleSortMenu

    local optionCorner = Instance.new("UICorner")
    optionCorner.CornerRadius = UDim.new(0, 4)
    optionCorner.Parent = optionButton

    option.Button = optionButton
end

local List = Instance.new("ScrollingFrame")
List.Size = UDim2.new(1, -30, 0, 154)
List.Position = UDim2.fromOffset(15, 168)
List.BackgroundColor3 = Color3.fromRGB(14, 14, 17)
List.BorderSizePixel = 0
List.ScrollBarThickness = 5
List.CanvasSize = UDim2.fromOffset(0, 0)
List.AutomaticCanvasSize = UserInputService.TouchEnabled and Enum.AutomaticSize.Y or Enum.AutomaticSize.None
List.ScrollingDirection = Enum.ScrollingDirection.Y
List.ElasticBehavior = Enum.ElasticBehavior.Always
List.Parent = Main

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 8)
ListCorner.Parent = List

local ListLayout = Instance.new("UIGridLayout")
ListLayout.CellSize = UserInputService.TouchEnabled
    and UDim2.new(0.5, -9, 0, 96)
    or UDim2.fromOffset(148, 72)
ListLayout.CellPadding = UserInputService.TouchEnabled
    and UDim2.fromOffset(8, 8)
    or UDim2.fromOffset(6, 6)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.FillDirectionMaxCells = UserInputService.TouchEnabled and 2 or 3
ListLayout.Parent = List

local QueueList = Instance.new("ScrollingFrame")
QueueList.Size = UDim2.new(1, -30, 0, 170)
QueueList.Position = UDim2.fromOffset(15, 108)
QueueList.BackgroundColor3 = Color3.fromRGB(14, 14, 17)
QueueList.BorderSizePixel = 0
QueueList.ScrollBarThickness = 5
QueueList.CanvasSize = UDim2.fromOffset(0, 0)
QueueList.AutomaticCanvasSize = UserInputService.TouchEnabled and Enum.AutomaticSize.Y or Enum.AutomaticSize.None
QueueList.ScrollingDirection = Enum.ScrollingDirection.Y
QueueList.ElasticBehavior = Enum.ElasticBehavior.Always
QueueList.Visible = false
QueueList.Parent = Main

local QueueListLayout = Instance.new("UIListLayout")
QueueListLayout.Padding = UDim.new(0, 6)
QueueListLayout.SortOrder = Enum.SortOrder.LayoutOrder
QueueListLayout.Parent = QueueList

local QueueListPadding = Instance.new("UIPadding")
QueueListPadding.PaddingTop = UDim.new(0, 3)
QueueListPadding.PaddingBottom = UDim.new(0, UserInputService.TouchEnabled and 28 or 3)
QueueListPadding.PaddingLeft = UDim.new(0, 6)
QueueListPadding.PaddingRight = UDim.new(0, 6)
QueueListPadding.Parent = QueueList

local ListPadding = Instance.new("UIPadding")
ListPadding.PaddingTop = UDim.new(0, 3)
ListPadding.PaddingBottom = UDim.new(0, UserInputService.TouchEnabled and 28 or 3)
ListPadding.PaddingLeft = UDim.new(0, 6)
ListPadding.PaddingRight = UDim.new(0, 6)
ListPadding.Parent = List

-- 휠을 멈추면 카드가 반쯤 걸리지 않도록 한 칸 단위로 정렬합니다.
local function EnableCardScrollSnap(ScrollingObject, CardPitch)
    local ChangeToken = 0
    local Adjusting = false

    ScrollingObject:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        if Adjusting then return end
        ChangeToken += 1
        local MyToken = ChangeToken

        task.delay(0.12, function()
            if MyToken ~= ChangeToken or not ScrollingObject.Parent then return end

            local MaxY = math.max(
                0,
                ScrollingObject.AbsoluteCanvasSize.Y
                    - ScrollingObject.AbsoluteWindowSize.Y
            )
            local SnappedY = math.clamp(
                math.floor(ScrollingObject.CanvasPosition.Y / CardPitch + 0.5)
                    * CardPitch,
                0,
                MaxY
            )

            Adjusting = true
            ScrollingObject.CanvasPosition = Vector2.new(0, SnappedY)
            Adjusting = false
        end)
    end)
end

-- 터치 관성 스크롤 중 지연된 Snap이 이전 위치로 되돌리는 문제를 막습니다.
-- PC 마우스휠에서는 기존 한 칸 정렬을 유지합니다.
if not UserInputService.TouchEnabled then
    EnableCardScrollSnap(List, 78)
    EnableCardScrollSnap(QueueList, 50)
end

-- 내용이 동적으로 바뀌는 경우에도 마지막 줄 아래의 터치 여유를 즉시 반영합니다.
ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    if not UserInputService.TouchEnabled then
        List.CanvasSize = UDim2.fromOffset(0, ListLayout.AbsoluteContentSize.Y + 12)
    end
end)
QueueListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    if not UserInputService.TouchEnabled then
        QueueList.CanvasSize = UDim2.fromOffset(0, QueueListLayout.AbsoluteContentSize.Y + 12)
    end
end)

local SelectedPanel = Instance.new("Frame")
SelectedPanel.Size = UDim2.new(1, -30, 0, 44)
SelectedPanel.Position = UDim2.fromOffset(15, 326)
SelectedPanel.BackgroundColor3 = Color3.fromRGB(34, 34, 41)
SelectedPanel.BorderSizePixel = 0
SelectedPanel.Parent = Main

local SelectedCorner = Instance.new("UICorner")
SelectedCorner.CornerRadius = UDim.new(0, 8)
SelectedCorner.Parent = SelectedPanel

local SelectedIcon = Instance.new("ImageLabel")
SelectedIcon.Size = UDim2.fromOffset(52, 34)
SelectedIcon.Position = UDim2.fromOffset(8, 5)
SelectedIcon.BackgroundColor3 = Color3.fromRGB(18, 18, 21)
SelectedIcon.BorderSizePixel = 0
SelectedIcon.ScaleType = Enum.ScaleType.Fit
SelectedIcon.Parent = SelectedPanel

local SelectedIconCorner = Instance.new("UICorner")
SelectedIconCorner.CornerRadius = UDim.new(0, 6)
SelectedIconCorner.Parent = SelectedIcon

local SelectedName = Instance.new("TextLabel")
SelectedName.Size = UDim2.new(1, -75, 0, 20)
SelectedName.Position = UDim2.fromOffset(70, 3)
SelectedName.BackgroundTransparency = 1
SelectedName.Text = "선택 차량 없음"
SelectedName.TextColor3 = Color3.fromRGB(245, 245, 245)
SelectedName.TextSize = 16
SelectedName.Font = Enum.Font.GothamBold
SelectedName.TextXAlignment = Enum.TextXAlignment.Left
SelectedName.Parent = SelectedPanel

local SelectedInfo = Instance.new("TextLabel")
SelectedInfo.Size = UDim2.new(1, -138, 0, 18)
SelectedInfo.Position = UDim2.fromOffset(70, 22)
SelectedInfo.BackgroundTransparency = 1
SelectedInfo.Text = ""
SelectedInfo.TextColor3 = Color3.fromRGB(180, 180, 188)
SelectedInfo.TextSize = 13
SelectedInfo.Font = Enum.Font.Gotham
SelectedInfo.TextXAlignment = Enum.TextXAlignment.Left
SelectedInfo.TextYAlignment = Enum.TextYAlignment.Center
SelectedInfo.RichText = true
SelectedInfo.Parent = SelectedPanel

local SelectedStars = Instance.new("Frame")
SelectedStars.Size = UDim2.fromOffset(58, 40)
SelectedStars.Position = UDim2.new(1, -63, 0, 2)
SelectedStars.BackgroundTransparency = 1
SelectedStars.Parent = SelectedPanel

local VehicleGoalUI = {}

VehicleGoalUI.Panel = Instance.new("Frame")
VehicleGoalUI.Panel.Size = UDim2.new(1, -30, 0, 30)
VehicleGoalUI.Panel.Position = UDim2.fromOffset(15, 372)
VehicleGoalUI.Panel.BackgroundColor3 = Color3.fromRGB(34, 34, 41)
VehicleGoalUI.Panel.BorderSizePixel = 0
VehicleGoalUI.Panel.Parent = Main

VehicleGoalUI.Label = Instance.new("TextLabel")
VehicleGoalUI.Label.Size = UDim2.fromOffset(78, 30)
VehicleGoalUI.Label.Position = UDim2.fromOffset(8, 0)
VehicleGoalUI.Label.BackgroundTransparency = 1
VehicleGoalUI.Label.Text = "목표 레벨"
VehicleGoalUI.Label.TextColor3 = Color3.fromRGB(235, 235, 240)
VehicleGoalUI.Label.TextSize = 14
VehicleGoalUI.Label.Font = Enum.Font.GothamBold
VehicleGoalUI.Label.TextXAlignment = Enum.TextXAlignment.Left
VehicleGoalUI.Label.Parent = VehicleGoalUI.Panel

VehicleGoalUI.Box = Instance.new("TextBox")
VehicleGoalUI.Box.Size = UDim2.fromOffset(66, 26)
VehicleGoalUI.Box.Position = UDim2.fromOffset(90, 2)
VehicleGoalUI.Box.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
VehicleGoalUI.Box.BorderSizePixel = 0
VehicleGoalUI.Box.ClearTextOnFocus = false
VehicleGoalUI.Box.Text = "100"
VehicleGoalUI.Box.TextColor3 = Color3.fromRGB(245, 245, 245)
VehicleGoalUI.Box.TextSize = 14
VehicleGoalUI.Box.Font = Enum.Font.GothamBold
VehicleGoalUI.Box.Parent = VehicleGoalUI.Panel

VehicleGoalUI.Apply = Instance.new("TextButton")
VehicleGoalUI.Apply.Size = UDim2.fromOffset(88, 26)
VehicleGoalUI.Apply.Position = UDim2.fromOffset(164, 2)
VehicleGoalUI.Apply.BackgroundColor3 = Color3.fromRGB(65, 80, 105)
VehicleGoalUI.Apply.BorderSizePixel = 0
VehicleGoalUI.Apply.Text = "목표 적용"
VehicleGoalUI.Apply.TextColor3 = Color3.new(1, 1, 1)
VehicleGoalUI.Apply.TextSize = 13
VehicleGoalUI.Apply.Font = Enum.Font.GothamBold
VehicleGoalUI.Apply.Parent = VehicleGoalUI.Panel

VehicleGoalUI.Detected = Instance.new("TextLabel")
VehicleGoalUI.Detected.Size = UDim2.new(1, -264, 1, 0)
VehicleGoalUI.Detected.Position = UDim2.fromOffset(264, 0)
VehicleGoalUI.Detected.BackgroundTransparency = 1
VehicleGoalUI.Detected.Text = "현재 감지: 선택 차량 없음"
VehicleGoalUI.Detected.TextColor3 = Color3.fromRGB(220, 220, 230)
VehicleGoalUI.Detected.TextSize = 12
VehicleGoalUI.Detected.TextWrapped = true
VehicleGoalUI.Detected.Font = Enum.Font.GothamBold
VehicleGoalUI.Detected.TextXAlignment = Enum.TextXAlignment.Left
VehicleGoalUI.Detected.Parent = VehicleGoalUI.Panel

UpdateVehicleGoalDisplay = function(goalLevel, detectedText)
    if VehicleGoalUI.Box and goalLevel then
        VehicleGoalUI.Box.Text = tostring(goalLevel)
    end
    if VehicleGoalUI.Detected and detectedText then
        VehicleGoalUI.Detected.Text = detectedText
    end
end

VehicleGoalUI.Apply.MouseButton1Click:Connect(function()
    if State.CurrentView == "Queue" then
        Queue.UpdateSelectedTarget()
    elseif type(ApplyVehicleGoalLevel) == "function" then
        ApplyVehicleGoalLevel(VehicleGoalUI.Box.Text)
    end
end)
VehicleGoalUI.Box.FocusLost:Connect(function(enterPressed)
    if not enterPressed then return end
    if State.CurrentView == "Queue" then
        Queue.UpdateSelectedTarget()
    elseif type(ApplyVehicleGoalLevel) == "function" then
        ApplyVehicleGoalLevel(VehicleGoalUI.Box.Text)
    end
end)

local StartFarm = Instance.new("TextButton")
StartFarm.Size = UDim2.fromOffset(210, 32)
StartFarm.Position = UDim2.fromOffset(15, 406)
StartFarm.BackgroundColor3 = Color3.fromRGB(55, 105, 165)
StartFarm.BorderSizePixel = 0
StartFarm.Text = "파밍 시작 · 차량 변경"
StartFarm.TextColor3 = Color3.new(1, 1, 1)
StartFarm.TextSize = 14
StartFarm.Font = Enum.Font.GothamBold
StartFarm.Parent = Main

local QueueAddButton = Instance.new("TextButton")
QueueAddButton.Size = UDim2.fromOffset(130, 32)
QueueAddButton.Position = UDim2.fromOffset(235, 406)
QueueAddButton.BackgroundColor3 = Color3.fromRGB(65, 80, 120)
QueueAddButton.BorderSizePixel = 0
QueueAddButton.Text = "대기열 추가"
QueueAddButton.TextColor3 = Color3.new(1, 1, 1)
QueueAddButton.TextSize = 13
QueueAddButton.Font = Enum.Font.GothamBold
QueueAddButton.Parent = Main

local AutoRespawnButton = Instance.new("TextButton")
AutoRespawnButton.Size = UDim2.fromOffset(110, 32)
AutoRespawnButton.Position = UDim2.fromOffset(375, 406)
AutoRespawnButton.BackgroundColor3 = Color3.fromRGB(50, 125, 80)
AutoRespawnButton.BorderSizePixel = 0
AutoRespawnButton.Text = "자동 재소환: 켜짐"
AutoRespawnButton.TextColor3 = Color3.new(1, 1, 1)
AutoRespawnButton.TextSize = 12
AutoRespawnButton.Font = Enum.Font.GothamBold
AutoRespawnButton.Parent = Main

local QueueControls = Instance.new("Frame")
QueueControls.Size = UDim2.new(1, -30, 0, 32)
QueueControls.Position = UDim2.fromOffset(15, 406)
QueueControls.BackgroundTransparency = 1
QueueControls.Visible = false
QueueControls.Parent = Main

local QueueButtons = {}
for index, info in ipairs({
    {"위로", 0},
    {"아래로", 94},
    {"목표 수정", 188},
    {"공격 설정", 282},
    {"선택 삭제", 376},
}) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.fromOffset(84, 32)
    button.Position = UDim2.fromOffset(info[2], 0)
    button.BackgroundColor3 = Color3.fromRGB(58, 68, 92)
    button.BorderSizePixel = 0
    button.Text = info[1]
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 13
    button.Font = Enum.Font.GothamBold
    button.Parent = QueueControls
    QueueButtons[index] = button
end

local AutoRespawnCorner = Instance.new("UICorner")
AutoRespawnCorner.CornerRadius = UDim.new(0, 8)
AutoRespawnCorner.Parent = AutoRespawnButton

local StartFarmCorner = Instance.new("UICorner")
StartFarmCorner.CornerRadius = UDim.new(0, 8)
StartFarmCorner.Parent = StartFarm

local TabButtons = {}

local function findSpawnRemote()
    local packages = ReplicatedStorage:FindFirstChild("Packages")
    local index = packages and packages:FindFirstChild("_Index")

    if not index then
        return nil
    end

    for _, object in ipairs(index:GetDescendants()) do
        if object:IsA("RemoteFunction")
        and object.Name == "Spawn"
        and object.Parent
        and object.Parent.Name == "RF" then
            local service = object.Parent.Parent
            if service and service.Name == "VehicleService" then
                return object
            end
        end
    end

    return nil
end

local function waitForAutomaticSeat(timeout)
    local deadline = os.clock() + timeout

    repeat
        local character = Player.Character
        local humanoid = character
            and character:FindFirstChildOfClass("Humanoid")

        if humanoid and humanoid.SeatPart then
            return true, humanoid.SeatPart
        end

        task.wait(0.25)
    until os.clock() >= deadline

    return false, nil
end

local function leaveCurrentVehicle()
    local character = Player.Character
    local humanoid = character
        and character:FindFirstChildOfClass("Humanoid")

    if not humanoid or not humanoid.SeatPart then
        return true
    end

    Status.Text = "기존 차량에서 자동 하차 중"
    humanoid.Sit = false
    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

    local deadline = os.clock() + 3
    repeat
        task.wait(0.1)
    until not humanoid.SeatPart or os.clock() >= deadline

    return humanoid.SeatPart == nil
end

local function spawnSelectedVehicle(isAutomatic)
    if State.Spawning then
        return
    end

    local spawnData = isAutomatic and State.ActiveFarmData or State.Selected
    if not spawnData then
        Status.Text = "차량을 먼저 선택하세요"
        return
    end
    if not isAutomatic then
        State.ActiveFarmData = spawnData
    end
    State.RecoveryFarmData = spawnData

    local uuid = spawnData.UUID
    if not isUUID(uuid) then
        Status.Text = "선택 차량의 고유번호(UUID)가 올바르지 않아 소환을 중단했습니다"
        return
    end

    local spawnRemote = findSpawnRemote()
    if not spawnRemote then
        Status.Text = "차량 소환 기능을 찾지 못함"
        if Queue.CurrentTransition and type(SendQueueSpawnFailure) == "function" then
            SendQueueSpawnFailure(spawnData, "차량 소환 기능을 찾지 못함", 1, #Queue.Entries)
        end
        return
    end

    if not isAutomatic then
        State.KeepRunning = true
        State.UnseatedSince = nil
        State.RespawnCount = 0
        if type(UpdateRespawnCount) == "function" then
            UpdateRespawnCount(State.RespawnCount)
        end
    end

    State.Spawning = true
    if type(StopIntegratedAttack) == "function" then
        StopIntegratedAttack(isAutomatic and "차량 파괴 · 자동 재소환 중" or "새 차량으로 변경 중")
    end
    StartFarm.Text = isAutomatic and "자동 재소환 중..." or "차량 소환 중..."
    StartFarm.BackgroundColor3 = Color3.fromRGB(72, 72, 82)

    task.spawn(function()
        local function fail(reason)
            Status.Text = reason
            State.Spawning = false
            StartFarm.Text = "파밍 시작 · 차량 변경"
            StartFarm.BackgroundColor3 = Color3.fromRGB(55, 105, 165)
            if Queue.CurrentTransition
            and not Queue.FailureNotified[spawnData.UUID]
            and type(SendQueueSpawnFailure) == "function" then
                Queue.FailureNotified[spawnData.UUID] = true
                SendQueueSpawnFailure(
                    spawnData,
                    reason,
                    1,
                    math.max(1, #Queue.Entries)
                )
            end
        end

        if not leaveCurrentVehicle() then
            fail("자동 하차 실패 · 직접 내린 뒤 다시 시도하세요")
            return
        end

        Status.Text = spawnData.Name .. " 소환 요청 중"

        local ok, response = pcall(function()
            return spawnRemote:InvokeServer(uuid)
        end)

        if not ok then
            fail("소환 요청 오류: " .. tostring(response))
            return
        end

        Status.Text = "소환 요청 완료 · 자동 탑승 대기 중"

        local seated = waitForAutomaticSeat(15)
        if seated then
            local character = Player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local seat = humanoid and humanoid.SeatPart
            local vehicleFolder = Workspace:FindFirstChild("Vehicles")
            local vehicle = seat
            while vehicle and vehicle.Parent and vehicle.Parent ~= vehicleFolder do
                vehicle = vehicle.Parent
            end
            State.ActiveVehicle = vehicle
                and vehicle:IsA("Model")
                and vehicle
                or (seat and seat:FindFirstAncestorOfClass("Model") or nil)
            State.Farming = true
            State.UnseatedSince = nil
            if isAutomatic then
                State.RespawnCount = State.RespawnCount + 1
                Queue.TotalRespawns = Queue.TotalRespawns + 1
                if type(UpdateRespawnCount) == "function" then
                    UpdateRespawnCount(State.RespawnCount)
                end
            end

            local completedQueueTransition = false
            if Queue.CurrentTransition
            and Queue.Entries[1]
            and Queue.Entries[1].UUID == Queue.CurrentTransition.UUID then
                completedQueueTransition = true
                table.remove(Queue.Entries, 1)
                Queue.CurrentTransition = nil
                State.QueueTransition = false
                if type(Queue.Save) == "function" then Queue.Save() end
                if type(Queue.Render) == "function" then Queue.Render() end
            end

            Status.Text = "탑승 완료: " .. spawnData.Name
            SelectedInfo.Text = SelectedInfo.Text .. "\n탑승 상태: 완료"
            if type(StartIntegratedAttack) == "function" then
                task.wait(0.25)
                StartIntegratedAttack(completedQueueTransition and false or isAutomatic)
            end
        else
            State.Farming = false
            State.ActiveVehicle = nil
            fail("15초 안에 자동 탑승 확인 안 됨 · 서버 응답: " .. tostring(response))
            return
        end

        State.Spawning = false
        StartFarm.Text = "파밍 시작 · 차량 변경"
        StartFarm.BackgroundColor3 = Color3.fromRGB(55, 105, 165)
    end)
end

local function starText(stars)
    stars = math.clamp(math.floor(tonumber(stars) or 0), 0, 5)

    if stars <= 0 then
        return "0성 · 별 없음"
    end

    return tostring(stars)
        .. '성 <font size="22" color="rgb(255,215,70)">★'
        .. "</font>"
end

local function renderSelectedStars(stars)
    for _, child in ipairs(SelectedStars:GetChildren()) do
        child:Destroy()
    end

    local count = math.clamp(math.floor(tonumber(stars) or 0), 0, 5)
    local function addStar(x, y, size, color, transparency)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.fromOffset(size + 7, size + 4)
        label.Position = UDim2.fromOffset(x, y)
        label.BackgroundTransparency = 1
        label.Text = "★"
        label.TextColor3 = color
        label.TextTransparency = transparency or 0
        label.TextSize = size
        label.Font = Enum.Font.GothamBold
        label.TextStrokeColor3 = Color3.new(0, 0, 0)
        label.TextStrokeTransparency = 0.05
        label.Parent = SelectedStars
    end

    if count == 5 then
        addStar(0, 2, 31, Color3.fromRGB(255, 75, 25), 0.55)
        addStar(2, 4, 27, Color3.fromRGB(255, 225, 65), 0)
    elseif count > 0 then
        local colors = {
            Color3.fromRGB(205, 95, 255),
            Color3.fromRGB(85, 170, 255),
            Color3.fromRGB(255, 215, 75),
            Color3.fromRGB(110, 255, 175),
        }
        for step = 1, count do
            addStar(1, 26 - ((step - 1) * 8), 12, colors[step], 0)
        end
    end

    local grade = Instance.new("TextLabel")
    grade.Size = UDim2.fromOffset(28, 16)
    grade.Position = UDim2.fromOffset(count == 5 and 31 or 18, 22)
    grade.BackgroundTransparency = 1
    grade.Text = tostring(count) .. "성"
    grade.TextColor3 = Color3.new(1, 1, 1)
    grade.TextSize = 10
    grade.Font = Enum.Font.GothamBold
    grade.TextStrokeTransparency = 0.1
    grade.Parent = SelectedStars
end

local function clearRows()
    for _, obj in ipairs(List:GetChildren()) do
        if obj:IsA("GuiObject") then
            obj:Destroy()
        end
    end
end

local function selectVehicle(data)
    State.Selected = data
    State.RecoveryFarmData = data

    SelectedIcon.Image = data.Image or ""
    SelectedName.Text = data.Name
    renderSelectedStars(data.Stars)

    SelectedInfo.Text =
        "레벨 "
        .. tostring(data.Level)
        .. "   ·   "
        .. tostring(CategoryName[data.Category] or data.Category or "-")
        .. "   ·   "
        .. starText(data.Stars)
        .. "   ·   "
        .. tostring(data.Rarity or "등급 미확인")
        .. ((tonumber(data.Platinum) or 0) > 0
            and (" · 플래티넘 " .. tostring(data.Platinum))
            or "")

    if type(UpdateSelectedVehicleCard) == "function" and not State.ActiveFarmData then
        UpdateSelectedVehicleCard(data)
    end
    if State.CurrentView == "Vehicles" and type(UpdateVehicleGoalDisplay) == "function" then
        UpdateVehicleGoalDisplay(100, "선택 차량: " .. tostring(data.Name) .. " · 현재 레벨 " .. tostring(data.Level))
    end
end

function Queue.Save()
    if type(writefile) ~= "function" then
        return false
    end
    local ok = pcall(function()
        writefile(Queue.ConfigFile, HttpService:JSONEncode({
            Entries = Queue.Entries,
        }))
    end)
    local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
    if not Queue.SuppressRecoverySync and Bridge and type(Bridge.OnRecoveryStateChanged) == "function" then
        Bridge.OnRecoveryStateChanged("대기열 변경")
    end
    return ok
end

function Queue.Load()
    if type(readfile) ~= "function" or type(isfile) ~= "function" then
        return
    end
    local ok, exists = pcall(isfile, Queue.ConfigFile)
    if not ok or not exists then
        return
    end
    local readOk, decoded = pcall(function()
        return HttpService:JSONDecode(readfile(Queue.ConfigFile))
    end)
    if readOk and type(decoded) == "table" and type(decoded.Entries) == "table" then
        Queue.Entries = decoded.Entries
    end
end

function Queue.FindData(entry)
    for _, category in ipairs({"Land", "Air", "Naval"}) do
        for _, data in ipairs(State.Owned[category]) do
            if data.UUID == entry.UUID then
                return data
            end
        end
    end
    return nil
end

function Queue.ClearRows()
    for _, object in ipairs(QueueList:GetChildren()) do
        if object:IsA("GuiObject") then
            object:Destroy()
        end
    end
end

function Queue.Render()
    Queue.ClearRows()
    QueueViewButton.Text = "파밍 대기열 " .. tostring(#Queue.Entries)

    for index, entry in ipairs(Queue.Entries) do
        local row = Instance.new("TextButton")
        row.Size = UDim2.new(1, -12, 0, 44)
        row.BackgroundColor3 = index == State.QueueSelectedIndex
            and Color3.fromRGB(56, 72, 104)
            or Color3.fromRGB(34, 34, 41)
        row.BorderSizePixel = 0
        row.Text = ""
        row.LayoutOrder = index
        row.Parent = QueueList

        local name = Instance.new("TextLabel")
        name.Size = UDim2.new(1, -20, 0, 20)
        name.Position = UDim2.fromOffset(10, 3)
        name.BackgroundTransparency = 1
        name.Text = tostring(index) .. ". " .. tostring(entry.Name)
        name.TextColor3 = Color3.fromRGB(245, 245, 245)
        name.TextSize = 16
        name.Font = Enum.Font.GothamBold
        name.TextXAlignment = Enum.TextXAlignment.Left
        name.Parent = row

        local info = Instance.new("TextLabel")
        info.Size = UDim2.new(1, -20, 0, 18)
        info.Position = UDim2.fromOffset(10, 23)
        info.BackgroundTransparency = 1
        info.Text = string.format(
            "등록 %s → 목표 %s · %s · %s",
            tostring(entry.InitialLevel or "-"),
            goalLevelText(entry.TargetLevel),
            entry.AttackSettings and entry.AttackSettings.GuidedPrimaryFamily and "슈레저형" or "기관총형",
            index == 1 and "다음 대기" or "대기"
        )
        info.TextColor3 = Color3.fromRGB(195, 195, 205)
        info.TextSize = 14
        info.Font = Enum.Font.Gotham
        info.TextXAlignment = Enum.TextXAlignment.Left
        info.Parent = row

        row.MouseButton1Click:Connect(function()
            State.QueueSelectedIndex = index
            local data = Queue.FindData(entry)
            if data then
                State.Selected = data
                SelectedIcon.Image = data.Image or ""
                SelectedName.Text = data.Name
                renderSelectedStars(data.Stars)
                SelectedInfo.Text =
                    "레벨 " .. tostring(data.Level)
                    .. "   ·   " .. tostring(CategoryName[data.Category] or data.Category or "-")
                    .. "   ·   " .. starText(data.Stars)
            end
            if type(UpdateVehicleGoalDisplay) == "function" then
                UpdateVehicleGoalDisplay(entry.TargetLevel or 100, "대기열 " .. index .. "번 · " .. tostring(entry.Name))
            end
            Queue.Render()
        end)
    end

    if #Queue.Entries == 0 then
        local empty = Instance.new("TextLabel")
        empty.Size = UDim2.new(1, -12, 0, 80)
        empty.BackgroundTransparency = 1
        empty.Text = "등록된 다음 차량이 없습니다.\n차량 선택 탭에서 대기열에 추가하세요."
        empty.TextColor3 = Color3.fromRGB(165, 165, 175)
        empty.TextSize = 14
        empty.TextWrapped = true
        empty.Font = Enum.Font.Gotham
        empty.Parent = QueueList
    end

    if not UserInputService.TouchEnabled then
        task.defer(function()
            QueueList.CanvasSize = UDim2.fromOffset(0, QueueListLayout.AbsoluteContentSize.Y + 12)
        end)
    end
end

function Queue.SetView(name)
    State.CurrentView = name
    local vehiclesVisible = name == "Vehicles"
    Tabs.Visible = vehiclesVisible
    VehicleSearchBox.Visible = vehiclesVisible
    VehicleSortButton.Visible = vehiclesVisible
    VehicleSortMenu.Visible = false
    List.Visible = vehiclesVisible
    QueueList.Visible = not vehiclesVisible
    StartFarm.Visible = vehiclesVisible
    QueueAddButton.Visible = vehiclesVisible
    AutoRespawnButton.Visible = vehiclesVisible
    QueueControls.Visible = not vehiclesVisible
    VehicleViewButton.BackgroundColor3 = vehiclesVisible and Color3.fromRGB(62, 82, 118) or Color3.fromRGB(46, 46, 53)
    QueueViewButton.BackgroundColor3 = not vehiclesVisible and Color3.fromRGB(62, 82, 118) or Color3.fromRGB(46, 46, 53)
    if not vehiclesVisible then
        Queue.Render()
    end
end

function Queue.AddSelected()
    local data = State.Selected
    if not data then
        Status.Text = "대기열에 넣을 차량을 먼저 선택하세요"
        return
    end
    if State.ActiveFarmData and State.ActiveFarmData.UUID == data.UUID then
        Status.Text = "현재 파밍 중인 차량은 대기열에 다시 넣을 수 없습니다"
        return
    end
    for _, entry in ipairs(Queue.Entries) do
        if entry.UUID == data.UUID then
            Status.Text = "이미 대기열에 등록된 차량입니다"
            return
        end
    end

    local target, targetError = parseGoalLevel(VehicleGoalUI.Box.Text)
    if target == nil then
        Status.Text = targetError
        return
    end
    table.insert(Queue.Entries, {
        UUID = data.UUID,
        Name = data.Name,
        Category = data.Category,
        InitialLevel = data.Level,
        TargetLevel = target,
        AttackSettings = type(CaptureAttackSettings) == "function" and CaptureAttackSettings() or nil,
    })
    if State.ActiveFarmData and State.KeepRunning and not Queue.SessionActive then
        Queue.SessionActive = true
        Queue.SessionStartedUnix = os.time()
        Queue.Completed = {}
        Queue.TotalRespawns = 0
    end
    Queue.Save()
    Queue.Render()
    Status.Text = data.Name .. " · 목표 " .. goalLevelText(target) .. " 대기열 추가 완료"
end

function Queue.UpdateSelectedTarget()
    local index = State.QueueSelectedIndex
    local entry = index and Queue.Entries[index]
    if not entry then
        Status.Text = "목표를 바꿀 대기 차량을 선택하세요"
        return
    end
    local target, targetError = parseGoalLevel(VehicleGoalUI.Box.Text)
    if target == nil then
        Status.Text = targetError
        return
    end
    entry.TargetLevel = target
    VehicleGoalUI.Box.Text = tostring(entry.TargetLevel)
    Queue.Save()
    Queue.Render()
    Status.Text = entry.Name .. " 목표 " .. goalLevelText(entry.TargetLevel) .. " 저장"
end

function Queue.MoveSelected(offset)
    local index = State.QueueSelectedIndex
    if not index then return end
    local target = index + offset
    if target < 1 or target > #Queue.Entries then return end
    Queue.Entries[index], Queue.Entries[target] = Queue.Entries[target], Queue.Entries[index]
    State.QueueSelectedIndex = target
    Queue.Save()
    Queue.Render()
end

function Queue.DeleteSelected()
    local index = State.QueueSelectedIndex
    if not index or not Queue.Entries[index] then return end
    table.remove(Queue.Entries, index)
    State.QueueSelectedIndex = nil
    Queue.Save()
    Queue.Render()
end

VehicleViewButton.MouseButton1Click:Connect(function() Queue.SetView("Vehicles") end)
QueueViewButton.MouseButton1Click:Connect(function() Queue.SetView("Queue") end)
QueueAddButton.MouseButton1Click:Connect(Queue.AddSelected)
QueueButtons[1].MouseButton1Click:Connect(function() Queue.MoveSelected(-1) end)
QueueButtons[2].MouseButton1Click:Connect(function() Queue.MoveSelected(1) end)
QueueButtons[3].MouseButton1Click:Connect(Queue.UpdateSelectedTarget)
QueueButtons[4].MouseButton1Click:Connect(function()
    local index = State.QueueSelectedIndex
    if not index or not Queue.Entries[index] then
        Status.Text = "공격 설정을 바꿀 대기 차량을 먼저 선택하세요"
        return
    end
    if type(OpenQueueAttackSettings) == "function" then
        OpenQueueAttackSettings(index)
    end
end)
QueueButtons[5].MouseButton1Click:Connect(Queue.DeleteSelected)
Queue.Load()
Queue.Render()

local function updateTabs()
    for category, button in pairs(TabButtons) do
        button.Text =
            CategoryName[category]
            .. " "
            .. #State.Owned[category]

        if category == State.CurrentTab then
            button.BackgroundColor3 = Color3.fromRGB(62, 82, 118)
        else
            button.BackgroundColor3 = Color3.fromRGB(46, 46, 53)
        end
    end
end

local function render()
    clearRows()

    local sourceVehicles = State.Owned[State.CurrentTab]
    local vehicles = {}
    local SearchText = lower(State.SearchText)

    for _, data in ipairs(sourceVehicles) do
        local VehicleName = lower(data.Name)
        if SearchText == ""
        or VehicleName:find(SearchText, 1, true) then
            table.insert(vehicles, data)
        end
    end

    table.sort(vehicles, function(a, b)
        local ALevel = tonumber(a.Level) or 0
        local BLevel = tonumber(b.Level) or 0
        local AStars = tonumber(a.Stars) or 0
        local BStars = tonumber(b.Stars) or 0

        if State.SortMode == "LevelDesc" then
            if ALevel == BLevel then
                return lower(a.Name) < lower(b.Name)
            end
            return ALevel > BLevel
        elseif State.SortMode == "StarAsc" then
            if AStars == BStars then
                if ALevel == BLevel then
                    return lower(a.Name) < lower(b.Name)
                end
                return ALevel < BLevel
            end
            return AStars < BStars
        elseif State.SortMode == "StarDesc" then
            if AStars == BStars then
                if ALevel == BLevel then
                    return lower(a.Name) < lower(b.Name)
                end
                return ALevel < BLevel
            end
            return AStars > BStars
        elseif State.SortMode == "NameAsc" then
            return lower(a.Name) < lower(b.Name)
        end

        if ALevel == BLevel then
            return lower(a.Name) < lower(b.Name)
        end
        return ALevel < BLevel
    end)

    for index, data in ipairs(vehicles) do
        local Card = Instance.new("TextButton")
        Card.Size = UDim2.fromOffset(148, 72)
        Card.BackgroundColor3 = State.RarityColors[data.Rarity] or Color3.fromRGB(48, 48, 54)
        Card.BorderSizePixel = 0
        Card.Text = ""
        Card.LayoutOrder = index
        Card.AutoButtonColor = false
        Card.Parent = List

        local CardCorner = Instance.new("UICorner")
        CardCorner.CornerRadius = UDim.new(0, 4)
        CardCorner.Parent = Card

        local CardStroke = Instance.new("UIStroke")
        CardStroke.Thickness = (tonumber(data.Platinum) or 0) > 0 and 3 or 2
        CardStroke.Color = (tonumber(data.Platinum) or 0) > 0
            and Color3.fromRGB(70, 255, 95)
            or Color3.fromRGB(16, 16, 18)
        CardStroke.Parent = Card

        local CardGradient = Instance.new("UIGradient")
        if (tonumber(data.Platinum) or 0) > 0 then
            CardGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 70, 95)),
                ColorSequenceKeypoint.new(0.22, Color3.fromRGB(255, 210, 55)),
                ColorSequenceKeypoint.new(0.42, Color3.fromRGB(75, 235, 120)),
                ColorSequenceKeypoint.new(0.62, Color3.fromRGB(55, 190, 255)),
                ColorSequenceKeypoint.new(0.82, Color3.fromRGB(125, 90, 255)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 75, 190)),
            })
        elseif data.Rarity == "Limited" then
            CardGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(18, 5, 7)),
                ColorSequenceKeypoint.new(0.48, Color3.fromRGB(175, 12, 20)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 5, 8)),
            })
        elseif data.Rarity == "Legendary" then
            CardGradient.Color = ColorSequence.new(
                Color3.fromRGB(255, 192, 42),
                Color3.fromRGB(155, 92, 18)
            )
        elseif data.Rarity == "Exotic" then
            CardGradient.Color = ColorSequence.new(
                Color3.fromRGB(235, 72, 175),
                Color3.fromRGB(90, 50, 150)
            )
        else
            CardGradient.Color = ColorSequence.new(
                Card.BackgroundColor3:Lerp(Color3.new(1, 1, 1), 0.14),
                Card.BackgroundColor3:Lerp(Color3.new(0, 0, 0), 0.18)
            )
        end
        CardGradient.Rotation = 25
        CardGradient.Parent = Card

        local VehicleImage = Instance.new("ImageLabel")
        VehicleImage.Size = UDim2.new(1, -8, 1, -22)
        VehicleImage.Position = UDim2.fromOffset(4, 16)
        VehicleImage.BackgroundTransparency = 1
        VehicleImage.Image = data.Image or ""
        VehicleImage.ScaleType = Enum.ScaleType.Fit
        VehicleImage.Parent = Card

        -- 사진마다 한 번만 확인합니다. 반복 Preload나 무한 재시도는 하지 않아 메모리가 쌓이지 않습니다.
        task.delay(3, function()
            if VehicleImage.Parent and not VehicleImage.IsLoaded then
                VehicleImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
            end
        end)

        local Name = Instance.new("TextLabel")
        Name.Size = UDim2.new(1, -8, 0, 17)
        Name.Position = UDim2.fromOffset(4, 1)
        Name.BackgroundTransparency = 1
        Name.Text = data.Name
        Name.TextColor3 = Color3.new(1, 1, 1)
        Name.TextSize = 12
        Name.Font = Enum.Font.GothamBold
        Name.TextXAlignment = Enum.TextXAlignment.Left
        Name.TextStrokeColor3 = Color3.new(0, 0, 0)
        Name.TextStrokeTransparency = 0.15
        Name.TextTruncate = Enum.TextTruncate.AtEnd
        Name.Parent = Card

        local Level = Instance.new("TextLabel")
        Level.Size = UDim2.fromOffset(78, 18)
        Level.Position = UDim2.new(1, -82, 1, -19)
        Level.BackgroundTransparency = 1
        Level.Text = "레벨 " .. tostring(data.Level)
        Level.TextColor3 = Color3.new(1, 1, 1)
        Level.TextSize = 12
        Level.Font = Enum.Font.GothamBold
        Level.TextXAlignment = Enum.TextXAlignment.Right
        Level.TextStrokeColor3 = Color3.new(0, 0, 0)
        Level.TextStrokeTransparency = 0.1
        Level.Parent = Card

        local StarCount = math.clamp(math.floor(tonumber(data.Stars) or 0), 0, 5)

        local function MakeCardStar(position, size, color, transparency)
            local Star = Instance.new("TextLabel")
            Star.Size = UDim2.fromOffset(size + 8, size + 5)
            Star.Position = position
            Star.BackgroundTransparency = 1
            Star.Text = "★"
            Star.TextColor3 = color
            Star.TextTransparency = transparency or 0
            Star.TextSize = size
            Star.Font = Enum.Font.GothamBold
            Star.TextXAlignment = Enum.TextXAlignment.Left
            Star.TextStrokeColor3 = Color3.new(0, 0, 0)
            Star.TextStrokeTransparency = 0.05
            Star.Parent = Card
            return Star
        end

        if StarCount == 5 then
            -- 큰 별 뒤에 정적 빛 테두리를 겹쳐 인게임의 5성 배지 느낌을 냅니다.
            MakeCardStar(UDim2.fromOffset(0, 42), 30, Color3.fromRGB(255, 70, 25), 0.55)
            MakeCardStar(UDim2.fromOffset(1, 43), 27, Color3.fromRGB(255, 155, 20), 0.25)
            MakeCardStar(UDim2.fromOffset(3, 45), 24, Color3.fromRGB(255, 235, 75), 0)
        elseif StarCount > 0 then
            -- 1~4성은 아래에서 위로 한 단계씩 쌓입니다.
            local StepColors = {
                Color3.fromRGB(205, 95, 255),
                Color3.fromRGB(85, 170, 255),
                Color3.fromRGB(255, 215, 75),
                Color3.fromRGB(110, 255, 175),
            }
            for Step = 1, StarCount do
                MakeCardStar(
                    UDim2.fromOffset(4, 55 - ((Step - 1) * 10)),
                    14,
                    StepColors[Step],
                    0
                )
            end
        end

        local StarGrade = Instance.new("TextLabel")
        StarGrade.Size = UDim2.fromOffset(35, 18)
        StarGrade.Position = StarCount == 5
            and UDim2.fromOffset(32, 52)
            or UDim2.fromOffset(20, 53)
        StarGrade.BackgroundTransparency = 1
        StarGrade.Text = tostring(StarCount) .. "성"
        StarGrade.TextColor3 = Color3.new(1, 1, 1)
        StarGrade.TextSize = 11
        StarGrade.Font = Enum.Font.GothamBold
        StarGrade.TextXAlignment = Enum.TextXAlignment.Left
        StarGrade.TextStrokeColor3 = Color3.new(0, 0, 0)
        StarGrade.TextStrokeTransparency = 0.1
        StarGrade.Parent = Card

        Card.MouseButton1Click:Connect(function()
            selectVehicle(data)
        end)
    end
    task.wait()

    if not UserInputService.TouchEnabled then
        List.CanvasSize = UDim2.fromOffset(
            0,
            ListLayout.AbsoluteContentSize.Y + 12
        )
    end

    updateTabs()

    Status.Text =
        CategoryName[State.CurrentTab]
        .. " 차량 "
        .. tostring(#vehicles)
        .. " / "
        .. tostring(#sourceVehicles)
        .. "대"
        .. (State.SearchText ~= "" and " · 검색 중" or "")

    if #vehicles == 0 then
        local Empty = Instance.new("TextLabel")
        Empty.Size = UDim2.new(1, -12, 0, 70)
        Empty.BackgroundTransparency = 1
        Empty.Text = "보유 차량 없음"
        Empty.TextColor3 = Color3.fromRGB(150, 150, 158)
        Empty.TextSize = 13
        Empty.Font = Enum.Font.Gotham
        Empty.Parent = List
    end
end

local function setTab(category)
    State.CurrentTab = category
    List.CanvasPosition = Vector2.new(0, 0)
    render()
end

for _, category in ipairs({"All", "Land", "Air", "Naval"}) do
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1/4, -4, 1, 0)
    Button.BackgroundColor3 = Color3.fromRGB(46, 46, 53)
    Button.TextColor3 = Color3.fromRGB(245, 245, 245)
    Button.TextSize = 15
    Button.Font = Enum.Font.GothamBold
    Button.Parent = Tabs

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 7)
    ButtonCorner.Parent = Button

    TabButtons[category] = Button

    Button.MouseButton1Click:Connect(function()
        setTab(category)
    end)
end

local function addUUIDRecord(uuid, record, container)
    if not isUUID(uuid) then
        return
    end

    if not isVehicleRecord(record) then
        return
    end

    State.UUIDRecords[uuid] =
        State.UUIDRecords[uuid] or {}
    table.insert(State.UUIDRecords[uuid], record)

    if type(container) == "table" then
        State.UUIDLinks[uuid] = State.UUIDLinks[uuid] or {}
        table.insert(State.UUIDLinks[uuid], {
            Container = container,
            Key = uuid,
        })
    end
end

local function addVehicleRecord(record)
    if not isVehicleRecord(record) then
        return
    end

    local vehicleId = safeRaw(record, "VehicleId")

    State.VehicleRecords[vehicleId] =
        State.VehicleRecords[vehicleId] or {}

    table.insert(State.VehicleRecords[vehicleId], record)
end

local function chooseBestRecord(records)
    if type(records) ~= "table" or #records == 0 then
        return nil
    end

    local best = nil
    local bestLevel = -1

    for _, record in ipairs(records) do
        if isVehicleRecord(record) then
            local level =
                tonumber(safeRaw(record, "Level"))
                or 0

            if level > bestLevel then
                bestLevel = level
                best = record
            end
        end
    end

    return best
end

State.ResolveVehicleCategory = function(vehicleId, record)
    local fields = {"VehicleType", "Category", "Type", "Class", "SpawnType"}
    for _, field in ipairs(fields) do
        local category = parseCategory(safeRaw(record, field))
        if category then return category end
    end
    local directCategory = State.VehicleTypes[vehicleId]
    if directCategory then return directCategory end
    for _, metadata in ipairs(State.VehicleRecords[vehicleId] or {}) do
        for _, field in ipairs(fields) do
            local category = parseCategory(safeRaw(metadata, field))
            if category then return category end
        end
    end
    return fallbackCategory(vehicleId)
end

local SearchChangeToken = 0

VehicleSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    State.SearchText = VehicleSearchBox.Text or ""
    SearchChangeToken += 1
    local MyToken = SearchChangeToken

    task.delay(0.08, function()
        if MyToken ~= SearchChangeToken then return end
        List.CanvasPosition = Vector2.new(0, 0)
        render()
    end)
end)

VehicleSortButton.MouseButton1Click:Connect(function()
    VehicleSortMenu.Visible = not VehicleSortMenu.Visible
end)

for _, option in ipairs(VehicleSortOptions) do
    option.Button.MouseButton1Click:Connect(function()
        State.SortMode = option.Mode
        VehicleSortButton.Text = "정렬: " .. option.Label
        VehicleSortMenu.Visible = false
        List.CanvasPosition = Vector2.new(0, 0)
        render()
    end)
end

local function scanData()
    if State.Loading then
        return
    end

    State.Loading = true

    Status.Text = "메모리 읽는 중"

    State.Owned.All = {}
    State.Owned.Land = {}
    State.Owned.Air = {}
    State.Owned.Naval = {}

    State.Images = {}
    State.VehicleTypes = {}
    State.VehicleRarity = {}
    State.UUIDRecords = {}
    State.UUIDLinks = {}
    State.VehicleRecords = {}

    if type(getgc) ~= "function" then
        Status.Text = "getgc 미지원"
        State.Loading = false
        return
    end

    local ok, gc = pcall(function()
        return getgc(true)
    end)

    if not ok or type(gc) ~= "table" then
        Status.Text = "메모리 읽기 실패"
        State.Loading = false
        return
    end

    local ownedUUIDs = {}
    local total = #gc

    for index, tbl in ipairs(gc) do
        if type(tbl) == "table" then
            pcall(function()
                local vehicleId = rawget(tbl, "VehicleId")

                if type(vehicleId) == "string"
                and vehicleId ~= "" then
                    addVehicleRecord(tbl)
                end

                for key, value in pairs(tbl) do
                    if type(key) == "string"
                    and type(value) == "string" then

                        if isUUID(value) then
                            ownedUUIDs[value] = true
                        end

                        if value:find("rbxassetid://", 1, true) then
                            State.Images[key] = value
                        end
                    end

                    if isUUID(key)
                    and type(value) == "table" then
                        -- 실제 원본 보유목록은 UUID가 값이 아니라 key인 구조입니다.
                        ownedUUIDs[key] = true
                        addUUIDRecord(key, value, tbl)
                    end

                    if type(value) == "table" then
                        local nestedVehicleId =
                            rawget(value, "VehicleId")

                        if type(nestedVehicleId) == "string"
                        and nestedVehicleId ~= "" then
                            addVehicleRecord(value)
                            for _, field in ipairs({"VehicleType", "Category", "Type", "Class", "SpawnType"}) do
                                local category = parseCategory(rawget(value, field))
                                if category then
                                    State.VehicleTypes[nestedVehicleId] = category
                                    break
                                end
                            end
                        end

                        local fields = {
                            "VehicleType",
                            "Category",
                            "Type",
                            "Class",
                            "SpawnType"
                        }

                        if type(key) == "string"
                        and rawget(value, "Class") == "Vehicle" then
                            local configImage =
                                rawget(value, "Image")
                                or rawget(value, "Icon")
                                or rawget(value, "Thumbnail")
                                or rawget(value, "ImageId")
                            if configImage ~= nil then
                                State.Images[key] = tostring(configImage)
                            end
                            local rarity = rawget(value, "Rarity")
                            if rawget(value, "Limited") == true
                            or rawget(value, "IsLimited") == true
                            or rawget(value, "Exclusive") == true then
                                State.VehicleRarity[key] = "Limited"
                            elseif rarity ~= nil then
                                State.VehicleRarity[key] = normalizeRarity(rarity)
                            end
                        end

                        if type(key) == "string" then
                            for _, field in ipairs(fields) do
                                local fieldValue =
                                    rawget(value, field)

                                if fieldValue ~= nil then
                                    local category =
                                        parseCategory(fieldValue)

                                    if category then
                                        State.VehicleTypes[key] =
                                            category
                                        break
                                    end
                                end
                            end
                        end

                        for nestedKey, nestedValue in pairs(value) do
                            if isUUID(nestedKey)
                            and type(nestedValue) == "table" then
                                addUUIDRecord(
                                    nestedKey,
                                    nestedValue,
                                    value
                                )
                            end
                        end
                    end
                end
            end)
        end

        if index % 15000 == 0 then
            Status.Text =
                "차량 데이터 읽는 중 "
                .. math.floor(index / total * 100)
                .. "%"

            task.wait()
        end
    end

    Status.Text = "실제 보유 차량 연결 중"

    local seenVehicleUUID = {}

    for uuid in pairs(ownedUUIDs) do
        local records = State.UUIDRecords[uuid]
        local record = chooseBestRecord(records)

        if record then
            local vehicleId =
                safeRaw(record, "VehicleId")

            if type(vehicleId) == "string"
            and vehicleId ~= ""
            and not seenVehicleUUID[uuid] then

                seenVehicleUUID[uuid] = true

                local level =
                    tonumber(safeRaw(record, "Level"))
                    or 0

                local stars =
                    tonumber(safeRaw(record, "Stars"))
                    or 0

                local category =
                    State.ResolveVehicleCategory(vehicleId, record)

                local rarity = normalizeRarity(
                    State.VehicleRarity[vehicleId]
                    or safeRaw(record, "Rarity")
                    or safeRaw(record, "Quality")
                    or safeRaw(record, "Tier")
                )
                if safeRaw(record, "Limited") == true
                or safeRaw(record, "IsLimited") == true
                or safeRaw(record, "Exclusive") == true then
                    rarity = "Limited"
                end

                table.insert(
                    State.Owned[category],
                    {
                        UUID = uuid,
                        Name = vehicleId,
                        Level = level,
                        Stars = stars,
                        Platinum =
                            tonumber(
                                safeRaw(record, "Platinum")
                            ) or 0,

                        Damage =
                            tonumber(
                                safeRaw(record, "Damage")
                            ) or 0,

                        Health =
                            tonumber(
                                safeRaw(record, "Health")
                            ) or 0,

                        Speed =
                            tonumber(
                                safeRaw(record, "Speed")
                            ) or 0,

                        Image =
                            State.Images[vehicleId]
                            or "",

                        Category = category,
                        Rarity = rarity,
                        Record = record
                    }
                )

                table.insert(
                    State.Owned.All,
                    State.Owned[category][#State.Owned[category]]
                )
            end
        end
    end

    for _, category in ipairs({
        "All",
        "Land",
        "Air",
        "Naval"
    }) do
        table.sort(
            State.Owned[category],
            function(a, b)
                return lower(a.Name) < lower(b.Name)
            end
        )
    end

    State.LastInventoryCount = #State.Owned.All
    State.LastInventoryScanAt = os.clock()
    State.Loading = false

    render()
end

-- 게임은 차량 탭을 처음 만들기 전까지 소환용 UUID 목록을 로컬에 넣지 않는 경우가 있습니다.
-- 사용자가 인벤토리를 직접 열지 않아도 되도록, 보유차량 창 첫 실행 때 버튼의 기존 로컬
-- Activated 처리만 한 번 호출합니다. 서버 Remote를 직접 호출하거나 반복 감시하지 않습니다.
local function normalizeButtonText(button)
    local parts = {button.Name}
    if button:IsA("TextButton") then
        table.insert(parts, button.Text)
    end
    return lower(table.concat(parts, " "))
end

local function buttonIsUsable(button, allowHidden)
    if not button:IsA("GuiButton") or button:IsDescendantOf(Gui) then
        return false
    end

    local current = button
    while current and current ~= PlayerGui do
        if not allowHidden and current:IsA("GuiObject") and not current.Visible then
            return false
        end
        if not allowHidden and current:IsA("LayerCollector") and not current.Enabled then
            return false
        end
        current = current.Parent
    end
    return true
end

local function findGameButton(keywords, allowHidden)
    local bestButton
    local bestScore = 0

    for _, object in ipairs(PlayerGui:GetDescendants()) do
        if buttonIsUsable(object, allowHidden) then
            local text = normalizeButtonText(object)
            local score = 0
            for index, keyword in ipairs(keywords) do
                if text == keyword then
                    score = math.max(score, 100 - index)
                elseif text:find(keyword, 1, true) then
                    score = math.max(score, 50 - index)
                end
            end
            if score > bestScore then
                bestButton = object
                bestScore = score
            end
        end
    end

    return bestButton
end

local function activateGameButton(button)
    if not button or not button.Parent then
        return false
    end

    if typeof(firesignal) == "function" then
        local ok = pcall(function()
            firesignal(button.Activated)
        end)
        if ok then
            return true
        end
    end

    return pcall(function()
        button:Activate()
    end)
end

local function bootstrapVehicleInventoryOnce()
    if State.InventoryBootstrapAttempted or State.InventoryBootstrapRunning then
        return State.InventoryBootstrapSucceeded
    end

    State.InventoryBootstrapAttempted = true
    State.InventoryBootstrapRunning = true
    Status.Text = "보유차량 자동 준비 중 · 인벤토리를 직접 열 필요 없음"

    local inventoryKeywords = {
        "inventory", "인벤토리", "items", "item", "장비", "backpack"
    }
    local inventoryButton = findGameButton(inventoryKeywords, false)
        or findGameButton(inventoryKeywords, true)

    if not inventoryButton or not activateGameButton(inventoryButton) then
        State.InventoryBootstrapRunning = false
        Status.Text = "자동 준비 실패 · 게임 인벤토리 버튼을 찾지 못했습니다"
        return false
    end

    task.wait(0.35)

    local vehicleKeywords = {
        "vehicles", "vehicle", "차량", "cars", "car"
    }
    local vehicleButton = findGameButton(vehicleKeywords, false)
        or findGameButton(vehicleKeywords, true)
    if vehicleButton then
        activateGameButton(vehicleButton)
    end

    -- 차량 탭의 로컬 UUID 테이블 생성만 기다립니다. 주기적 감시는 하지 않습니다.
    task.wait(0.9)
    scanData()

    -- 같은 인벤토리 버튼의 기존 토글 처리를 다시 불러 화면에 남지 않게 닫습니다.
    if inventoryButton.Parent then
        activateGameButton(inventoryButton)
    end

    State.InventoryBootstrapSucceeded = State.LastInventoryCount > 0
    State.InventoryBootstrapRunning = false

    if not State.InventoryBootstrapSucceeded then
        Status.Text = vehicleButton
            and "자동 준비 후에도 차량 UUID가 생성되지 않았습니다 · 새로고침으로 한 번 더 확인하세요"
            or "자동 준비 실패 · 게임 차량 탭 버튼을 찾지 못했습니다"
    end

    return State.InventoryBootstrapSucceeded
end

local function loadOwnedVehiclesForPopup(forceRefresh)
    if State.Loading or State.InventoryBootstrapRunning then
        return
    end

    if forceRefresh or State.LastInventoryCount == 0
    or os.clock() - State.LastInventoryScanAt >= 60 then
        scanData()
    end

    if State.LastInventoryCount == 0 then
        bootstrapVehicleInventoryOnce()
    end
end

Refresh.MouseButton1Click:Connect(function()
    if not State.Loading then
        State.Selected = nil
        SelectedIcon.Image = ""
        SelectedName.Text = "선택 차량 없음"
        SelectedInfo.Text = ""
        renderSelectedStars(0)

        -- 수동 새로고침은 현재 로컬 자료만 다시 읽습니다. 자동 UI 준비는 실행당 1회뿐입니다.
        task.spawn(function()
            loadOwnedVehiclesForPopup(true)
        end)
    end
end)

StartFarm.MouseButton1Click:Connect(function()
    if not State.Selected then
        spawnSelectedVehicle(false)
        return
    end

    if type(ApplyVehicleGoalLevel) == "function" then
        if ApplyVehicleGoalLevel(VehicleGoalUI.Box.Text) == false then
            return
        end
    end
    State.ActiveFarmData = State.Selected
    State.RecoveryFarmData = State.Selected
    State.FarmInitialLevel = tonumber(State.Selected.Level) or 0
    Queue.SessionActive = #Queue.Entries > 0
    Queue.SessionStartedUnix = os.time()
    Queue.Completed = {}
    Queue.TotalRespawns = 0
    Queue.CurrentTransition = nil
    table.clear(Queue.FailureNotified)

    if type(SaveFarmRecoveryDirect) == "function" then
        SaveFarmRecoveryDirect("파밍 시작 버튼")
    end

    local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
    if Bridge and type(Bridge.OnFarmPrepared) == "function" then
        local saved = Bridge.OnFarmPrepared()
        if saved == false then
            Status.Text = "복구 파일 저장 실패 · 실행기의 writefile/readfile 지원을 확인하세요"
        else
            Status.Text = "복구 파일 저장 확인 완료 · 차량 소환 시작"
        end
    end

    spawnSelectedVehicle(false)
    Main.Visible = false
    if type(SetAttackPanelVisible) == "function" then
        SetAttackPanelVisible(true)
    end
end)

AutoRespawnButton.MouseButton1Click:Connect(function()
    State.AutoRespawn = not State.AutoRespawn
    AutoRespawnButton.Text = State.AutoRespawn
        and "자동 재소환: 켜짐"
        or "자동 재소환: 꺼짐"
    AutoRespawnButton.BackgroundColor3 = State.AutoRespawn
        and Color3.fromRGB(50, 125, 80)
        or Color3.fromRGB(75, 75, 86)
end)

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
    if type(SetAttackPanelVisible) == "function" then
        SetAttackPanelVisible(true)
    end
end)

updateTabs()
render()

task.spawn(function()
    while Gui.Parent do
        if State.AutoRespawn
        and State.KeepRunning
        and not State.Spawning
        and State.ActiveFarmData then
            local character = Player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local seat = humanoid and humanoid.SeatPart
            local vehicleRemoved = State.ActiveVehicle and not State.ActiveVehicle.Parent
            local needsRecovery = vehicleRemoved or not seat

            if needsRecovery then
                State.UnseatedSince = State.UnseatedSince or os.clock()
                if os.clock() - State.UnseatedSince >= 5
                and os.clock() - State.LastRespawnAttempt >= 5 then
                    State.LastRespawnAttempt = os.clock()
                    State.UnseatedSince = nil
                    State.ActiveVehicle = nil
                    spawnSelectedVehicle(true)
                end
            else
                State.UnseatedSince = nil
            end
        else
            State.UnseatedSince = nil
        end
        task.wait(0.5)
    end
end)

-- 차량 전체 조회는 자동팜 화면을 열 때만 실행합니다.
-- 스크립트 로드 직후의 반복 getgc 조회는 다클라 성능을 위해 제거했습니다.

SetVehicleWatchdogEnabled = function(enabled)
    State.KeepRunning = enabled == true
    if not State.KeepRunning then
        State.Farming = false
        State.UnseatedSince = nil
    end
end

GetSelectedVehicleSnapshot = function()
    local data = State.ActiveFarmData or State.Selected
    if not data then
        return nil
    end

    local bestRecord = data.Record
    local bestLevel = tonumber(bestRecord and safeRaw(bestRecord, "Level")) or tonumber(data.Level) or 0

    for _, record in ipairs(State.UUIDRecords[data.UUID] or {}) do
        local vehicleId = safeRaw(record, "VehicleId")
        local recordLevel = tonumber(safeRaw(record, "Level"))
        if vehicleId == data.Name and recordLevel and recordLevel >= bestLevel then
            bestRecord = record
            bestLevel = recordLevel
        end
    end

    for _, link in ipairs(State.UUIDLinks[data.UUID] or {}) do
        local currentRecord = safeRaw(link.Container, link.Key)
        if isVehicleRecord(currentRecord) then
            local vehicleId = safeRaw(currentRecord, "VehicleId")
            local recordLevel = tonumber(safeRaw(currentRecord, "Level"))
            if vehicleId == data.Name and recordLevel and recordLevel >= bestLevel then
                bestRecord = currentRecord
                bestLevel = recordLevel
            end
        end
    end

    if bestRecord then
        data.Record = bestRecord
    end
    local level = bestLevel
    local stars = tonumber(bestRecord and safeRaw(bestRecord, "Stars")) or tonumber(data.Stars) or 0
    data.Level = level
    data.Stars = stars

    if State.Selected == data then
        renderSelectedStars(stars)
        SelectedInfo.Text =
            "레벨 " .. tostring(level)
            .. "   ·   " .. tostring(CategoryName[data.Category] or data.Category or "-")
            .. "   ·   " .. starText(stars)
    end

    if type(UpdateSelectedVehicleCard) == "function" then
        UpdateSelectedVehicleCard(data)
    end

    return {
        UUID = data.UUID,
        Name = data.Name,
        Level = level,
        Stars = stars,
        RespawnCount = State.RespawnCount or 0,
        InitialLevel = State.FarmInitialLevel or level,
    }
end

OnVehicleGoalCompleted = function(completion)
    if not Queue.SessionActive then
        local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
        if Bridge and type(Bridge.OnFarmAllCompleted) == "function" then Bridge.OnFarmAllCompleted() end
        return false
    end

    table.insert(Queue.Completed, {
        Name = completion.Name,
        Level = completion.Level,
        TargetLevel = completion.TargetLevel,
        Elapsed = completion.Elapsed,
        RespawnCount = completion.RespawnCount,
    })

    if #Queue.Entries == 0 then
        Queue.SessionActive = false
        Queue.CurrentTransition = nil
        if type(SendQueueAllComplete) == "function" then
            SendQueueAllComplete(
                Queue.Completed,
                Queue.SessionStartedUnix or os.time(),
                Queue.TotalRespawns
            )
        end
        Queue.Save()
        Queue.Render()
        local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
        if Bridge and type(Bridge.OnFarmAllCompleted) == "function" then Bridge.OnFarmAllCompleted() end
        return {
            Handled = true,
            Final = true,
            Remaining = 0,
        }
    end

    local entry = Queue.Entries[1]
    local nextData = Queue.FindData(entry)
    if not nextData then
        if type(SendQueueSpawnFailure) == "function" then
            SendQueueSpawnFailure(
                {Name = entry.Name, UUID = entry.UUID},
                "대기 차량 데이터를 찾지 못함",
                1,
                #Queue.Entries
            )
        end
        return {
            Handled = true,
            Final = false,
            NextName = entry.Name,
            Remaining = #Queue.Entries,
        }
    end

    Queue.CurrentTransition = entry
    State.QueueTransition = true
    if type(ApplyAttackSettings) == "function" then
        ApplyAttackSettings(entry.AttackSettings)
        entry.AttackSettings = type(CaptureAttackSettings) == "function" and CaptureAttackSettings() or entry.AttackSettings
        Queue.Save()
    end
    State.Selected = nextData
    State.ActiveFarmData = nextData
    State.FarmInitialLevel = tonumber(nextData.Level) or tonumber(entry.InitialLevel) or 0
    selectVehicle(nextData)

    if type(ApplyVehicleGoalLevel) == "function" then
        ApplyVehicleGoalLevel(entry.TargetLevel or 100)
    end
    Queue.Render()

    task.delay(1, function()
        if Queue.SessionActive and Queue.CurrentTransition == entry then
            spawnSelectedVehicle(false)
        end
    end)
    return {
        Handled = true,
        Final = false,
        NextName = entry.Name,
        Remaining = #Queue.Entries,
    }
end

OpenVehiclePopup = function()
    if type(SetAttackPanelVisible) == "function" then
        SetAttackPanelVisible(false)
    end
    Queue.SetView("Vehicles")
    Main.Visible = true
end

CloseIntegratedApplication = function()
    if type(CloseIntegratedAttack) == "function" then
        CloseIntegratedAttack()
    end
    if Gui and Gui.Parent then
        Gui:Destroy()
    end
end


-- ============================================================
-- V1.7 공통 자동공격 통합부
-- ============================================================

-- V2.6 통합부 · 좌클릭/F 동시 공격 + F 직접 유도발사 시험본입니다.
-- F 자동사용 기본값은 켜짐이며, 지원 구조를 찾지 못하면 F만 자동으로 꺼집니다.
-- F 오류는 복사 가능한 로그 상자에 유지되며, 공격 범위 기본값은 5,000입니다.
-- 물리 F 키 대신 현재 탑승 차량의 Secondary Remote에 표적 위치와 부품을 직접 전달합니다.
-- 좌클릭 자동사용은 기본 켜짐이며, 꺼짐 상태에서는 Weapon.FireAt을 호출하지 않습니다.
-- 실전 검증 완료: 좌클릭·F 개별 토글 정상, F 즉시 유도 정상, 렉 없음.
-- MedicHeli에 탑승한 뒤 실행하고 '자동공격 시작'을 누르세요.
-- 2,000 이내에서 가장 가까운 살아 있는 NPC F35·보트를 선택합니다.
-- 마우스·크로스헤드는 변경하지 않고 포신 조준과 발사 명령에 대상 위치를 직접 전달합니다.
-- 탄약이 0이면 장전 명령을 한 번 보내고, 장전 후 공격을 계속합니다.
-- F5, 정지 버튼, X 버튼은 직접 공격 반복을 즉시 중단합니다.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Old = PlayerGui:FindFirstChild("ShowTimeAutoFarmV13")
    or PlayerGui:FindFirstChild("ShowTimeAutoFarmV13FriendlyFilterTest")
    or PlayerGui:FindFirstChild("ShowTimeAutoFarmV12")
    or PlayerGui:FindFirstChild("ShowTimeAutoFarmV12QueueTest")
    or PlayerGui:FindFirstChild("ShowTimeAutoFarmV11")
    or PlayerGui:FindFirstChild("ShowTimeAutoFarmV14VehicleLevelTest")
    or PlayerGui:FindFirstChild("ShowTimeAutoFarmV13CompletionTest")
    or PlayerGui:FindFirstChild("ShowTimeAutoFarmV12MultiLevelTest")
    or PlayerGui:FindFirstChild("ShowTimeAutoFarmV11DiscordTest")
    or PlayerGui:FindFirstChild("ShowTimeAutoFarmV10")
    or PlayerGui:FindFirstChild("IntegratedCommonAutoAttackV26RouteTest")
    or PlayerGui:FindFirstChild("IntegratedCommonAutoAttackV25")
    or PlayerGui:FindFirstChild("IntegratedCommonAutoAttackV24")
    or PlayerGui:FindFirstChild("IntegratedCommonAutoAttackV23")
    or PlayerGui:FindFirstChild("IntegratedCommonAutoAttackV22")
    or PlayerGui:FindFirstChild("IntegratedCommonAutoAttackV21")
    or PlayerGui:FindFirstChild("IntegratedCommonAutoAttackV20")
    or PlayerGui:FindFirstChild("IntegratedCommonAutoAttackV19")
    or PlayerGui:FindFirstChild("MedicHeliDirectTurretAttackV17DualToggle")
    or PlayerGui:FindFirstChild("MedicHeliDirectTurretAttackV16ImmediateLock")
    or PlayerGui:FindFirstChild("MedicHeliDirectTurretAttackV15ExecutorF")
    or PlayerGui:FindFirstChild("MedicHeliDirectTurretAttackV14FLog")
    or PlayerGui:FindFirstChild("MedicHeliDirectTurretAttackV13FToggle")
    or PlayerGui:FindFirstChild("MedicHeliDirectTurretAttackV12")
    or PlayerGui:FindFirstChild("MedicHeliAutoFarmAttackTestV11")
    or PlayerGui:FindFirstChild("MedicHeliAutoFarmAttackTestV10")
if Old then
    Old:Destroy()
end

local State = {
    Running = false,
    PrimaryEnabled = true,
    PrimaryAvailable = false,
    PrimaryMode = "탐색 전",
    PrimaryTarget = nil,
    FTarget = nil,
    PrimaryAttackCount = 0,
    FAttackCount = 0,
    AssignmentTurn = "Primary",
    LastReleasedTarget = nil,
    LastReleasedAt = 0,
    CurrentTarget = nil,
    CurrentDistance = nil,
    FireRemote = nil,
    WeaponModel = nil,
    ShootParts = nil,
    AmmoInfo = nil,
    LockController = nil,
    CalculateArcTarget = nil,
    AmmoChanged = nil,
    FireInterval = 0.1,
    LastFire = 0,
    ReloadRequested = false,
    FAutoEnabled = true,
    SecondaryAvailable = false,
    SecondaryMode = "탐색 전",
    SecondaryRemote = nil,
    SecondaryVehicle = nil,
    SecondaryController = nil,
    SecondaryLockPart = nil,
    SecondaryInterval = 0.7,
    LockingEvent = nil,
    FKeyDown = false,
    FPress = nil,
    FRelease = nil,
    FTap = nil,
    FInputMode = nil,
    FInjectedTarget = nil,
    FPreviousIsLocking = nil,
    LastFUse = 0,
    WorkElapsed = 0,
    WorkStartedAt = nil,
    FarmStartedUnix = nil,
    RouteEnabled = true,
    RouteRunning = false,
    RouteIndex = 1,
    RouteVehicle = nil,
    RouteErrorLogged = false,
    DiscordWebhook = "",
    DiscordEnabled = true,
    DiscordStorageAvailable = false,
    DiscordStatus = "설정 확인 중",
    GoalLevel = 100,
    CurrentDetectedLevel = nil,
    Level100Notified = {},
    Connections = {},
}

Config = {
    MaxTargetDistance = 5000,
    TargetRefreshInterval = 0.25,
    FUseInterval = 1.0,
    FKeyHoldTime = 0.05,
    RouteSpeed = 200,
    RouteHeight = 1000,
    RouteArrivalDistance = 8,
    AttackBoats = true,
    PrimaryF35 = true,
    FF35 = true,
    PrimaryBoats = true,
    FBoats = false,
    PrimaryAttackLimit = 0,
    FAttackLimit = 0,
    GuidedPrimaryFamily = false,
}

CaptureAttackSettings = function()
    return {
        AttackBoats = Config.AttackBoats == true,
        PrimaryF35 = Config.PrimaryF35 == true,
        FF35 = Config.FF35 == true,
        PrimaryBoats = Config.PrimaryBoats == true,
        FBoats = Config.FBoats == true,
        PrimaryAttackLimit = math.max(0, tonumber(Config.PrimaryAttackLimit) or 0),
        FAttackLimit = math.max(0, tonumber(Config.FAttackLimit) or 0),
        GuidedPrimaryFamily = Config.GuidedPrimaryFamily == true,
    }
end

ApplyAttackSettings = function(settings)
    if type(settings) ~= "table" then
        return false
    end
    Config.AttackBoats = settings.AttackBoats ~= false
    Config.PrimaryF35 = settings.PrimaryF35 ~= false
    Config.FF35 = settings.FF35 ~= false
    Config.PrimaryBoats = settings.PrimaryBoats ~= false
    Config.FBoats = settings.FBoats == true
    Config.PrimaryAttackLimit = math.clamp(tonumber(settings.PrimaryAttackLimit) or 0, 0, 20)
    Config.FAttackLimit = math.clamp(tonumber(settings.FAttackLimit) or 0, 0, 20)
    Config.GuidedPrimaryFamily = settings.GuidedPrimaryFamily == true
    return true
end

SaveFarmRecoveryDirect = function()
    local data = State.ActiveFarmData or State.RecoveryFarmData or State.Selected
    local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
    local function fail(reason)
        if Bridge then Bridge.RecoveryWriteVerified = false; Bridge.RecoveryWriteError = tostring(reason) end
        warn("[복구저장오류] " .. tostring(reason))
        return false
    end
    if not data or type(data.UUID) ~= "string" then return fail("차량 UUID 없음") end
    if type(writefile) ~= "function" then return fail("writefile 쓰기 기능 없음") end
    if type(readfile) ~= "function" then return fail("readfile 읽기 기능 없음") end
    if type(isfile) ~= "function" then return fail("isfile 확인 기능 없음") end
    local entries = {}
    for _, entry in ipairs(Queue.Entries or {}) do
        table.insert(entries, {
            UUID = entry.UUID,
            Name = entry.Name,
            Category = entry.Category,
            InitialLevel = tonumber(entry.InitialLevel) or 0,
            TargetLevel = tonumber(entry.TargetLevel) or 100,
            AttackSettings = type(entry.AttackSettings) == "table" and entry.AttackSettings
                or (type(CaptureAttackSettings) == "function" and CaptureAttackSettings() or nil),
        })
    end
    local payload = {
        Version = 33,
        UserId = Player.UserId,
        Pending = true,
        UpdatedAt = os.time(),
        SessionStartedUnix = State.FarmStartedUnix or os.time(),
        VehicleUUID = data.UUID,
        VehicleName = data.Name,
        InitialLevel = tonumber(State.FarmInitialLevel) or tonumber(data.Level) or 0,
        GoalLevel = tonumber(State.GoalLevel) or 100,
        QueueEntries = entries,
        AttackType = Config.GuidedPrimaryFamily and "슈레저형 유도탄" or "일반 기관총",
        GuidedPrimaryFamily = Config.GuidedPrimaryFamily == true,
        AttackSettings = CaptureAttackSettings(),
        PrimaryEnabled = State.PrimaryEnabled ~= false,
        FAutoEnabled = State.FAutoEnabled ~= false,
    }
    local fileName = "showtime_farm_recovery_v30_" .. tostring(Player.UserId) .. ".json"
    local encodeOk, encoded = pcall(HttpService.JSONEncode, HttpService, payload)
    if not encodeOk then return fail("JSON 변환 오류") end
    local writeOk = pcall(writefile, fileName, encoded)
    if not writeOk then return fail("파일 쓰기 오류") end
    local existsOk, exists = pcall(isfile, fileName)
    if not existsOk then return fail("저장 파일 확인 오류") end
    if not exists then return fail("저장 직후 파일 없음") end
    local readOk, raw = pcall(readfile, fileName)
    if not readOk then return fail("저장 파일 다시 읽기 오류") end
    local decodeOk, check = pcall(HttpService.JSONDecode, HttpService, raw)
    if not decodeOk or type(check) ~= "table" then return fail("저장 JSON 읽기 오류") end
    if check.Pending ~= true then return fail("복구 활성 표시 재검증 불일치") end
    if tostring(check.VehicleUUID or "") ~= tostring(data.UUID) then return fail("차량 UUID 재검증 불일치") end
    if Bridge then Bridge.RecoveryWriteVerified = true; Bridge.RecoveryWriteError = nil end
    return true
end

local UI = {}

local Target = {
    Candidates = {},
    HealthSources = {},
    Connections = {},
}

local Weapon = {}
local Farm = {}
local Work = {}
local Discord = {
    ConfigFile = "showtime_auto_farm_config.json",
    AccountFile = "showtime_level_alert_v11_" .. tostring(Player.UserId) .. ".json",
}
local Route = {
    CollisionState = {},
    Waypoints = {
        Vector3.new(-2260, 1000, -1733),
        Vector3.new(-2608, 1000, -433),
        Vector3.new(-2260, 1000, 867),
        Vector3.new(-1308, 1000, 1818),
        Vector3.new(-8, 1000, 2167),
        Vector3.new(1292, 1000, 1818),
        Vector3.new(2243, 1000, 867),
        Vector3.new(2592, 1000, -433),
        Vector3.new(2243, 1000, -1733),
        Vector3.new(1292, 1000, -2685),
        Vector3.new(-8, 1000, -3033),
        Vector3.new(-1308, 1000, -2685),
    },
}

function Discord.GetRequest()
    if type(request) == "function" then
        return request
    end
    if type(http_request) == "function" then
        return http_request
    end
    if type(syn) == "table" and type(syn.request) == "function" then
        return syn.request
    end
    return nil
end

function Discord.SetStatus(text)
    State.DiscordStatus = tostring(text or "")
    if UI.DiscordStatus then
        UI.DiscordStatus.Text = State.DiscordStatus
    end
end

function Discord.SaveConfig()
    if type(writefile) ~= "function" then
        State.DiscordStorageAvailable = false
        Discord.SetStatus("저장 미지원 · 이번 실행에서만 설정 유지")
        return false
    end
    local ok, message = pcall(function()
        writefile(Discord.ConfigFile, HttpService:JSONEncode({
            Webhook = State.DiscordWebhook,
        }))
        writefile(Discord.AccountFile, HttpService:JSONEncode({
            Enabled = State.DiscordEnabled,
            GoalLevel = State.GoalLevel,
            Notified = State.Level100Notified,
        }))
    end)
    State.DiscordStorageAvailable = ok
    Discord.SetStatus(ok and ("저장 완료 · " .. Player.Name .. " 계정별 기록 사용") or ("저장 오류: " .. tostring(message)))
    return ok
end

function Discord.LoadConfig()
    if type(readfile) ~= "function" or type(isfile) ~= "function" then
        State.DiscordStorageAvailable = false
        Discord.SetStatus("저장 미지원 · 이번 실행에서만 설정 유지")
        return
    end
    State.DiscordStorageAvailable = type(writefile) == "function"

    local commonOk, commonExists = pcall(isfile, Discord.ConfigFile)
    if commonOk and commonExists then
        local ok, decoded = pcall(function()
            return HttpService:JSONDecode(readfile(Discord.ConfigFile))
        end)
        if ok and type(decoded) == "table" then
            State.DiscordWebhook = tostring(decoded.Webhook or "")
        end
    end

    local accountOk, accountExists = pcall(isfile, Discord.AccountFile)
    if accountOk and accountExists then
        local ok, decoded = pcall(function()
            return HttpService:JSONDecode(readfile(Discord.AccountFile))
        end)
        if ok and type(decoded) == "table" then
            State.DiscordEnabled = decoded.Enabled ~= false
            State.GoalLevel = math.clamp(math.floor(tonumber(decoded.GoalLevel) or 100), 0, 100)
            State.Level100Notified = type(decoded.Notified) == "table" and decoded.Notified or {}
        end
    end

    if State.DiscordWebhook ~= "" then
        Discord.SetStatus("공통 웹훅·" .. Player.Name .. " 계정 설정 불러오기 완료")
    else
        Discord.SetStatus("웹훅을 한 번 입력하고 저장해 주세요")
    end
end

function Discord.Send(message)
    if State.DiscordWebhook == "" then
        return false, "웹훅 주소가 비어 있습니다."
    end
    local requester = Discord.GetRequest()
    if not requester then
        return false, "실행기가 외부 요청 함수를 지원하지 않습니다."
    end
    local ok, response = pcall(requester, {
        Url = State.DiscordWebhook,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({content = message}),
    })
    if not ok then
        return false, tostring(response)
    end
    local status = tonumber(response and (response.StatusCode or response.Status))
    if status and status ~= 200 and status ~= 204 then
        return false, "HTTP " .. tostring(status) .. " · " .. tostring(response.Body or "")
    end
    return true
end

function Discord.Test()
    if UI.WebhookBox and UI.WebhookBox.Text ~= "" then
        State.DiscordWebhook = UI.WebhookBox.Text
        UI.WebhookBox.Text = ""
    end
    Discord.SaveConfig()
    local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
    if Bridge and type(Bridge.OnRecoveryStateChanged) == "function" then Bridge.OnRecoveryStateChanged("목표 레벨 변경") end
    Discord.SetStatus("시험 메시지 전송 중...")
    task.spawn(function()
        local ok, message = Discord.Send("✅ 쇼타임 자동 팜 디스코드 전송 시험 성공")
        Discord.SetStatus(ok and "전송 시험 성공" or ("전송 시험 실패: " .. tostring(message)))
    end)
end

function Discord.FormatKoreanTime(unixTime)
    local parts = DateTime.fromUnixTimestamp(unixTime or os.time()):ToLocalTime()
    local period = parts.Hour >= 12 and "오후" or "오전"
    local hour = parts.Hour % 12
    if hour == 0 then
        hour = 12
    end
    return string.format(
        "%04d-%02d-%02d %s %d시 %02d분",
        parts.Year, parts.Month, parts.Day, period, hour, parts.Minute
    )
end

function Discord.FormatDuration(totalSeconds)
    local total = math.max(0, math.floor(totalSeconds or 0))
    local hours = math.floor(total / 3600)
    local minutes = math.floor((total % 3600) / 60)
    if hours > 0 then
        return string.format("%d시간 %d분", hours, minutes)
    end
    if minutes > 0 then
        return string.format("%d분", minutes)
    end
    return string.format("%d초", total)
end

function Discord.Dismount()
    local character = Player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.SeatPart then
        humanoid.Sit = false
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end

function Discord.CheckLevel100()
    if type(GetSelectedVehicleSnapshot) ~= "function" then
        return
    end
    local data = GetSelectedVehicleSnapshot()
    State.CurrentDetectedLevel = data and data.Level or nil
    if type(UpdateVehicleGoalDisplay) == "function" then
        UpdateVehicleGoalDisplay(
            nil,
            data
                and ("현재 감지: " .. tostring(data.Name) .. " · 레벨 " .. tostring(data.Level))
                or "현재 감지: 선택 차량 없음"
        )
    end

    -- 목표 0은 무제한입니다. 완료 판정·자동 정지·완료 알림·대기열 전환을 하지 않습니다.
    if State.GoalLevel == 0 then
        return
    end

    local notifiedKey = data and (tostring(data.UUID) .. "@" .. tostring(State.GoalLevel)) or nil
    if not State.DiscordEnabled
    or not State.Running
    or not data
    or data.Level < State.GoalLevel then
        return
    end

    local shouldSendCompletion = not State.Level100Notified[notifiedKey]
    State.Level100Notified[notifiedKey] = true
    Discord.SaveConfig()
    if type(SetVehicleWatchdogEnabled) == "function" then
        SetVehicleWatchdogEnabled(false)
    end
    Farm.Stop("목표 레벨 " .. tostring(State.GoalLevel) .. " 달성 · 자동파밍 즉시 정지")
    Discord.Dismount()

    local elapsed = math.max(0, math.floor(State.WorkElapsed or 0))
    local completedGoal = State.GoalLevel
    local queueResult
    if type(OnVehicleGoalCompleted) == "function" then
        queueResult = OnVehicleGoalCompleted({
            Name = data.Name,
            Level = data.Level,
            TargetLevel = completedGoal,
            Elapsed = elapsed,
            RespawnCount = data.RespawnCount,
            InitialLevel = data.InitialLevel,
        })
    end

    local stars = data.Stars > 0 and ("★ " .. data.Stars .. "성") or "0성 · 별 없음"
    local headline = completedGoal == 100
        and "🎉 **차량 레벨 100 달성!**"
        or ("🎉 **차량 목표 레벨 " .. tostring(completedGoal) .. " 달성!**")
    local message = string.format(
        "%s\n\n차량: %s\n레벨: %d → %d\n별 등급: %s\n작업시간: %s\n재소환: %d회\n계정: %s\n달성시간: %s\n걸린시간: %s",
        headline,
        tostring(data.Name),
        tonumber(data.InitialLevel) or data.Level,
        data.Level,
        stars,
        Discord.FormatKoreanTime(State.FarmStartedUnix or os.time()),
        tonumber(data.RespawnCount) or 0,
        Player.Name,
        Discord.FormatKoreanTime(os.time()),
        Discord.FormatDuration(elapsed)
    )
    if queueResult and queueResult.NextName then
        message = message
            .. "\n\n다음 차량: " .. tostring(queueResult.NextName)
            .. "\n남은 대기열: " .. tostring(queueResult.Remaining or 0) .. "대"
    elseif queueResult and queueResult.Final then
        message = message .. "\n\n대기열의 마지막 차량까지 완료했습니다."
    end

    if shouldSendCompletion then
        task.spawn(function()
            local ok, errorMessage = Discord.Send(message)
            Discord.SetStatus(ok and ("목표 레벨 " .. completedGoal .. " 알림 완료") or ("목표 달성 · 전송 실패: " .. tostring(errorMessage)))
        end)
    else
        Discord.SetStatus("이전에 알림을 보낸 목표 · 대기열 전환은 계속 진행")
    end
end

Discord.LoadConfig()

ApplyVehicleGoalLevel = function(value)
    local goal, goalError = parseGoalLevel(value)
    if goal == nil then
        Discord.SetStatus(goalError)
        if Status then
            Status.Text = goalError
        end
        return false
    end
    State.GoalLevel = goal
    if type(UpdateVehicleGoalDisplay) == "function" then
        UpdateVehicleGoalDisplay(State.GoalLevel)
    end
    Discord.SaveConfig()
    Discord.SetStatus(State.GoalLevel == 0
        and "목표 무제한 적용 완료 · 다음 차량 자동 전환 안 함"
        or ("목표 레벨 " .. State.GoalLevel .. " 적용 완료"))
    if Status then
        Status.Text = State.GoalLevel == 0
            and "목표 무제한 · 사용자가 정지할 때까지 계속 파밍"
            or ("목표 레벨 " .. State.GoalLevel .. " 적용 완료")
    end
    return true
end

if type(UpdateVehicleGoalDisplay) == "function" then
    UpdateVehicleGoalDisplay(State.GoalLevel)
end

SendQueueSpawnFailure = function(data, reason, position, total)
    local target = Queue.CurrentTransition and Queue.CurrentTransition.TargetLevel or 100
    local message = string.format(
        "⚠️ **다음 대기 차량 소환 실패**\n\n계정: %s\n차량: %s\n대기열 위치: %d/%d\n목표 레벨: %s\n실패 내용: %s\n상태: 5초 후 같은 차량 자동 재시도",
        Player.Name,
        tostring(data and data.Name or "알 수 없음"),
        tonumber(position) or 1,
        tonumber(total) or 1,
        goalLevelText(target),
        tostring(reason)
    )
    task.spawn(function()
        Discord.Send(message)
    end)
end

SendQueueAllComplete = function(completed, startedUnix, totalRespawns)
    local lines = {
        "✅ **전체 차량 파밍 완료!**",
        "",
        "계정: " .. Player.Name,
        "완료 차량: " .. tostring(#completed) .. "대",
        "전체 작업시간: " .. Discord.FormatDuration(os.time() - startedUnix),
        "총 재소환: " .. tostring(totalRespawns or 0) .. "회",
        "",
    }
    for index, item in ipairs(completed) do
        table.insert(lines, string.format(
            "%d. %s · 목표 %s 달성 · 걸린 시간 %s",
            index,
            tostring(item.Name),
            goalLevelText(item.TargetLevel),
            Discord.FormatDuration(item.Elapsed)
        ))
    end
    table.insert(lines, "")
    table.insert(lines, "현재 상태: 자동파밍 정지 · 차량 하차 완료")
    task.spawn(function()
        Discord.Send(table.concat(lines, "\n"))
    end)
end

function Route.ResolveVehicle()
    local character = Player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local seat = humanoid and humanoid.SeatPart
    if not seat then
        return nil
    end

    local vehicleFolder = Workspace:FindFirstChild("Vehicles")
    local current = seat
    while current and current.Parent and current.Parent ~= vehicleFolder do
        current = current.Parent
    end

    if current and current:IsA("Model") then
        return current
    end
    return seat:FindFirstAncestorOfClass("Model")
end

function Route.FindNearestIndex(position)
    local nearestIndex = 1
    local nearestDistance = math.huge
    for index, point in ipairs(Route.Waypoints) do
        local dx = position.X - point.X
        local dz = position.Z - point.Z
        local distance = dx * dx + dz * dz
        if distance < nearestDistance then
            nearestDistance = distance
            nearestIndex = index
        end
    end
    return nearestIndex
end

function Route.ApplyNoCollision(vehicle)
    table.clear(Route.CollisionState)
    for _, object in ipairs(vehicle:GetDescendants()) do
        if object:IsA("BasePart") then
            Route.CollisionState[object] = object.CanCollide
            object.CanCollide = false
        end
    end
end

function Route.RestoreCollision()
    for part, canCollide in pairs(Route.CollisionState) do
        if part and part.Parent then
            part.CanCollide = canCollide
        end
    end
    table.clear(Route.CollisionState)
end

function Route.Attach(vehicle)
    if State.RouteVehicle == vehicle then
        return
    end
    Route.RestoreCollision()
    State.RouteVehicle = vehicle
    State.RouteIndex = Route.FindNearestIndex(vehicle:GetPivot().Position)
    State.RouteErrorLogged = false
    Route.ApplyNoCollision(vehicle)
end

function Route.Start()
    State.RouteRunning = State.RouteEnabled
    if not State.RouteRunning then
        return
    end
    local vehicle = Route.ResolveVehicle()
    if vehicle then
        Route.Attach(vehicle)
    end
end

function Route.Stop()
    State.RouteRunning = false
    State.RouteVehicle = nil
    Route.RestoreCollision()
end

function Route.Step(deltaTime)
    if not State.RouteEnabled or not State.RouteRunning then
        return
    end

    local vehicle = Route.ResolveVehicle()
    if not vehicle or not vehicle.Parent then
        return
    end
    Route.Attach(vehicle)

    local current = vehicle:GetPivot()
    local target = Route.Waypoints[State.RouteIndex]
    local offset = target - current.Position
    local distance = offset.Magnitude

    if distance <= Config.RouteArrivalDistance then
        State.RouteIndex = State.RouteIndex % #Route.Waypoints + 1
        target = Route.Waypoints[State.RouteIndex]
        offset = target - current.Position
        distance = offset.Magnitude
    end
    if distance <= 0.001 then
        return
    end

    local step = math.min(Config.RouteSpeed * math.min(deltaTime, 0.1), distance)
    local nextPosition = current.Position + offset.Unit * step
    local lookTarget = distance > step and target or Route.Waypoints[State.RouteIndex % #Route.Waypoints + 1]
    local ok, message = pcall(function()
        vehicle:PivotTo(CFrame.lookAt(nextPosition, lookTarget))
        local root = vehicle.PrimaryPart
        if root then
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
        end
    end)
    if not ok and not State.RouteErrorLogged then
        State.RouteErrorLogged = true
        Farm.AddLog("경로 이동 오류: " .. tostring(message))
    end
end

function Route.RefreshButton()
    if not UI.RouteToggle then
        return
    end
    UI.RouteToggle.Text = State.RouteEnabled and "경로 이동: 켜짐" or "경로 이동: 꺼짐"
    UI.RouteToggle.BackgroundColor3 = State.RouteEnabled
        and Color3.fromRGB(50, 135, 82)
        or Color3.fromRGB(88, 88, 98)
end

function Route.Toggle()
    State.RouteEnabled = not State.RouteEnabled
    if State.RouteEnabled and State.Running then
        Route.Start()
    else
        Route.Stop()
    end
    Route.RefreshButton()
end

local function lower(value)
    return string.lower(tostring(value or ""))
end

function Target.IsWantedName(name)
    local text = lower(name)
    return text:find("f35", 1, true) ~= nil
        or text:find("f-35", 1, true) ~= nil
        or text:find("gunboat", 1, true) ~= nil
        or text:find("gun boat", 1, true) ~= nil
        or text:find("patrolboat", 1, true) ~= nil
        or text:find("patrol boat", 1, true) ~= nil
        or text == "boat"
end

function Target.IsBoat(model)
    local text = lower(model and model.Name)
    return text:find("boat", 1, true) ~= nil
end

function Target.IsF35(model)
    local text = lower(model and model.Name)
    return text:find("f35", 1, true) ~= nil
        or text:find("f-35", 1, true) ~= nil
end

function Target.ChannelAllows(model, channel)
    if Target.IsBoat(model) then
        if not Config.AttackBoats then return false end
        if channel == "Primary" then return Config.PrimaryBoats end
        return Config.FBoats
    end
    if Target.IsF35(model) then
        if channel == "Primary" then return Config.PrimaryF35 end
        return Config.FF35
    end
    return false
end

function Target.AddCandidate(object)
    if object:IsA("Model") and Target.IsWantedName(object.Name) then
        Target.Candidates[object] = true
    end
end

function Target.BuildCache()
    table.clear(Target.Candidates)
    table.clear(Target.HealthSources)

    for _, object in ipairs(Workspace:GetDescendants()) do
        Target.AddCandidate(object)
    end

    table.insert(Target.Connections, Workspace.DescendantAdded:Connect(function(object)
        Target.AddCandidate(object)
    end))

    table.insert(Target.Connections, Workspace.DescendantRemoving:Connect(function(object)
        Target.Candidates[object] = nil
        Target.HealthSources[object] = nil
        if State.CurrentTarget == object then
            State.CurrentTarget = nil
        end
    end))
end

function Target.IsPlayerCharacter(model)
    return model:IsA("Model")
        and Players:GetPlayerFromCharacter(model) ~= nil
end

function Target.HasPlayerOccupant(model)
    for _, object in ipairs(model:GetDescendants()) do
        if object:IsA("Seat") or object:IsA("VehicleSeat") then
            local humanoid = object.Occupant
            if humanoid and humanoid.Parent
            and Players:GetPlayerFromCharacter(humanoid.Parent) then
                return true
            end
        end
    end
    return false
end

function Target.ReadCachedHealth(source)
    if not source or not source.Object or not source.Object.Parent then
        return nil
    end

    if source.Kind == "Humanoid" then
        return source.Object.Health
    elseif source.Kind == "Attribute" then
        local ok, value = pcall(function()
            return source.Object:GetAttribute(source.Key)
        end)
        return ok and tonumber(value) or nil
    elseif source.Kind == "Value" then
        return tonumber(source.Object.Value)
    end

    return nil
end

function Target.ReadHealth(model)
    local saved = Target.HealthSources[model]
    if saved then
        return Target.ReadCachedHealth(saved)
    end

    local humanoid = model:FindFirstChildOfClass("Humanoid")
        or model:FindFirstChildWhichIsA("Humanoid", true)
    if humanoid then
        Target.HealthSources[model] = {
            Kind = "Humanoid",
            Object = humanoid,
        }
        return humanoid.Health
    end

    local objects = {model}
    for _, object in ipairs(model:GetDescendants()) do
        table.insert(objects, object)
    end

    local source
    for _, object in ipairs(objects) do
        for key, value in pairs(object:GetAttributes()) do
            local name = lower(key)
            local number = tonumber(value)
            local healthName = name:find("health", 1, true)
                or name == "hp"
                or name:find("hitpoint", 1, true)
                or name:find("durability", 1, true)

            if number and healthName and not name:find("max", 1, true) then
                if name:find("current", 1, true)
                or name == "health"
                or name == "hp"
                or name == "durability" then
                    source = {
                        Kind = "Attribute",
                        Object = object,
                        Key = key,
                    }
                    break
                end
            end
        end

        if source then
            break
        end

        if object:IsA("NumberValue") or object:IsA("IntValue") then
            local name = lower(object.Name)
            local healthName = name:find("health", 1, true)
                or name == "hp"
                or name:find("hitpoint", 1, true)
                or name:find("durability", 1, true)
            if healthName and not name:find("max", 1, true) then
                source = {
                    Kind = "Value",
                    Object = object,
                }
                break
            end
        end
    end

    if source then
        Target.HealthSources[model] = source
        return Target.ReadCachedHealth(source)
    end

    return nil
end

function Target.GetAimPart(model)
    if not model or not model.Parent then
        return nil
    end

    local preferred = model.PrimaryPart
    for _, name in ipairs({"Body", "Main", "Hull", "Hitbox"}) do
        local part = model:FindFirstChild(name, true)
        if part and part:IsA("BasePart") then
            preferred = part
            break
        end
    end

    return preferred or model:FindFirstChildWhichIsA("BasePart", true)
end

function Target.GetPosition(model)
    local preferred = Target.GetAimPart(model)
    if preferred then
        return preferred.Position
    end

    local ok, pivot = pcall(model.GetPivot, model)
    return ok and pivot.Position or nil
end

function Target.GetOrigin()
    local character = Player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local seat = humanoid and humanoid.SeatPart
    if seat then
        return seat.Position
    end

    local root = character and character:FindFirstChild("HumanoidRootPart")
    return root and root.Position or nil
end

function Target.IsFriendly(model)
    local current = model
    for _ = 1, 6 do
        if not current or current == Workspace then
            break
        end
        local ok, value = pcall(function()
            return current:GetAttribute("HighlightIsFriendly")
        end)
        if ok and value ~= nil then
            return value == true
        end
        current = current.Parent
    end
    return false
end

function Target.IsAlive(model)
    if not model or not model.Parent then
        return false
    end
    if Target.IsPlayerCharacter(model)
    or Target.HasPlayerOccupant(model)
    or Target.IsFriendly(model) then
        return false
    end
    local health = Target.ReadHealth(model)
    return health ~= nil and health > 0
end

function Target.FindNearest()
    local origin = Target.GetOrigin()
    if not origin then
        return nil, nil
    end

    local nearest, nearestDistance
    for model in pairs(Target.Candidates) do
        if not model.Parent then
            Target.Candidates[model] = nil
            Target.HealthSources[model] = nil
        elseif Target.IsAlive(model) then
            local position = Target.GetPosition(model)
            if position then
                local distance = (position - origin).Magnitude
                if distance <= Config.MaxTargetDistance
                and (not nearestDistance or distance < nearestDistance) then
                    nearest = model
                    nearestDistance = distance
                end
            end
        end
    end

    return nearest, nearestDistance
end

function Target.FindNearestForChannel(channel, excluded)
    local origin = Target.GetOrigin()
    if not origin then return nil, nil end
    local nearest, nearestDistance
    for model in pairs(Target.Candidates) do
        if model ~= excluded and Target.ChannelAllows(model, channel)
        and Target.IsAlive(model) then
            local position = Target.GetPosition(model)
            if position then
                local distance = (position - origin).Magnitude
                if distance <= Config.MaxTargetDistance
                and (not nearestDistance or distance < nearestDistance) then
                    nearest, nearestDistance = model, distance
                end
            end
        end
    end
    return nearest, nearestDistance
end


function Weapon.GetReaders()
    return getconstants or (debug and debug.getconstants),
        getupvalues or (debug and debug.getupvalues)
end

function Weapon.GetSeatedVehicle()
    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    local seatPart = humanoid and humanoid.SeatPart
    local vehiclesFolder = Workspace:FindFirstChild("Vehicles")
    if not seatPart or not vehiclesFolder then return nil end
    local vehicle = seatPart
    while vehicle and vehicle.Parent ~= vehiclesFolder do
        vehicle = vehicle.Parent
    end
    return vehicle and vehicle:IsA("Model") and vehicle or nil
end

function Weapon.IsShootFunction(fn, readConstants)
    local ok, constants = pcall(readConstants, fn)
    if not ok or type(constants) ~= "table" then
        return false
    end

    local wanted = {
        FireServer = false,
        ManuallyDeductedAmmo = false,
        GetTargetParts = false,
        ScreenPointToRay = false,
    }

    for _, value in pairs(constants) do
        if wanted[value] ~= nil then
            wanted[value] = true
        end
    end

    return wanted.FireServer
        and wanted.ManuallyDeductedAmmo
        and wanted.GetTargetParts
        and wanted.ScreenPointToRay
end

function Weapon.IsGuidedVehicleFunction(fn, readConstants)
    local ok, constants = pcall(readConstants, fn)
    if not ok or type(constants) ~= "table" then return false end
    local found = {FireServer = false, ScreenPointToRay = false, GetTargetParts = false}
    for _, value in pairs(constants) do
        if found[value] ~= nil then found[value] = true end
    end
    return found.FireServer and found.ScreenPointToRay and found.GetTargetParts
end

function Weapon.ResolveGuidedVehicle(objects, readConstants, readUpvalues, currentVehicle)
    for _, fn in ipairs(objects) do
        if type(fn) == "function"
        and (type(islclosure) ~= "function" or islclosure(fn))
        and Weapon.IsGuidedVehicleFunction(fn, readConstants) then
            local ok, values = pcall(readUpvalues, fn)
            if ok and type(values) == "table" then
                local vehicle = values[2]
                local remote = values[3]
                local controller = values[13]
                local ammoInfo = values[14]
                if typeof(vehicle) == "Instance" and vehicle:IsA("Model")
                and typeof(remote) == "Instance" and remote:IsA("RemoteEvent")
                and remote.Name == "Fire" and remote:IsDescendantOf(vehicle)
                and type(controller) == "table" and type(ammoInfo) == "table"
                and currentVehicle and (vehicle == currentVehicle or vehicle:IsDescendantOf(currentVehicle)) then
                    State.FireRemote = remote
                    State.FireInterval = tonumber(values[5]) or 0.1
                    State.WeaponModel = vehicle
                    State.ShootParts = nil
                    State.LockController = controller
                    State.AmmoInfo = ammoInfo
                    State.AmmoChanged = values[19]
                    State.CalculateArcTarget = values[20]
                    State.PrimaryMode = "강제락온"
                    State.PrimaryAvailable = true
                    return true
                end
            end
        end
    end
    return false
end

function Weapon.Resolve()
    State.PrimaryAvailable = false
    State.PrimaryMode = "탐색 중"
    State.FireRemote = nil
    State.WeaponModel = nil
    State.ShootParts = nil
    State.AmmoInfo = nil
    State.LockController = nil
    State.CalculateArcTarget = nil
    State.AmmoChanged = nil
    local currentVehicle = Weapon.GetSeatedVehicle()
    if not currentVehicle then
        State.PrimaryMode = "지원되지 않음"
        return false, "현재 탑승 차량을 확인하지 못했습니다."
    end
    local readConstants, readUpvalues = Weapon.GetReaders()
    if type(getgc) ~= "function"
    or type(readConstants) ~= "function"
    or type(readUpvalues) ~= "function" then
        return false, "실행기가 함수 내부 읽기 기능을 지원하지 않습니다."
    end

    local ok, objects = pcall(getgc, true)
    if not ok or type(objects) ~= "table" then
        return false, "실행 중 함수 목록을 읽지 못했습니다."
    end

    -- 기본값은 기존 정상 기관총(ShooterV2) 전용입니다.
    -- 사용자가 슈레저형을 선택한 경우 이 경로를 전혀 탐색하지 않습니다.
    if not Config.GuidedPrimaryFamily then
      for _, fn in ipairs(objects) do
        if type(fn) == "function"
        and (type(islclosure) ~= "function" or islclosure(fn))
        and Weapon.IsShootFunction(fn, readConstants) then
            local valuesOk, values = pcall(readUpvalues, fn)
            if valuesOk and type(values) == "table" then
                local remote = values[3]
                local weaponModel = values[6]
                local shootParts = values[7]
                local ammoInfo = values[14]
                if typeof(remote) == "Instance"
                and remote:IsA("RemoteEvent")
                and remote.Name == "Fire"
                and typeof(weaponModel) == "Instance"
                and type(shootParts) == "table"
                and type(ammoInfo) == "table" then
                    State.FireRemote = remote
                    State.FireInterval = tonumber(values[5]) or 0.1
                    State.WeaponModel = weaponModel
                    State.ShootParts = shootParts
                    State.LockController = values[13]
                    State.AmmoInfo = ammoInfo
                    State.AmmoChanged = values[19]
                    State.CalculateArcTarget = values[20]
                    State.PrimaryMode = "직접발사"
                    State.PrimaryAvailable = true
                    return true
                end
            end
        end
      end
    end

    -- 슈레저형은 사용자가 상세 설정에서 직접 선택한 경우에만 탐색합니다.
    if Config.GuidedPrimaryFamily
    and Weapon.ResolveGuidedVehicle(objects, readConstants, readUpvalues, currentVehicle) then
        return true
    end

    State.PrimaryAvailable = false
    State.PrimaryMode = "지원되지 않음"
    return false, Config.GuidedPrimaryFamily
        and "슈레저형 좌클릭 유도탄 구조를 찾지 못했습니다."
        or "일반 기관총 좌클릭 구조를 찾지 못했습니다."
end

function Weapon.GetAmmo()
    local ammo = State.AmmoInfo and State.AmmoInfo.Ammo
    return ammo and tonumber(ammo.Value) or nil
end

function Weapon.GetShootPart()
    local part = State.ShootParts and State.ShootParts[1]
    return typeof(part) == "Instance" and part:IsA("BasePart") and part or nil
end

function Weapon.Reload()
    if State.ReloadRequested or not State.FireRemote then
        return
    end
    State.ReloadRequested = true
    State.FireRemote:FireServer(3)
    Farm.SetStatus("탄약 소진 · 자동 장전 중...", true)
end

function Weapon.FireAt(model)
    if not State.Running or not Target.IsAlive(model) then
        return false
    end

    local ammo = Weapon.GetAmmo()
    if ammo ~= nil and ammo <= 0 then
        Weapon.Reload()
        return false
    end

    if State.ReloadRequested then
        if ammo == nil or ammo <= 0 then
            return false
        end
        State.ReloadRequested = false
    end

    if os.clock() - State.LastFire < State.FireInterval then
        return false
    end

    if State.PrimaryMode == "강제락온" then
        local targetPart = Target.GetAimPart(model)
        local targetPoint = Target.GetPosition(model)
        if not targetPart or not targetPoint or not State.FireRemote then return false end
        local targetParts = Target.IsF35(model) and {targetPart} or {}
        State.FireRemote:FireServer(2, targetPoint, nil, nil, nil, nil, targetParts)
        if ammo ~= nil and State.AmmoInfo and State.AmmoInfo.Ammo then
            State.AmmoInfo.Ammo.Value = math.max(0, ammo - 1)
            if type(State.AmmoChanged) == "function" then pcall(State.AmmoChanged) end
        end
        State.LastFire = os.clock()
        return true
    end

    local targetPart = Target.GetAimPart(model)
    local shootPart = Weapon.GetShootPart()
    local targetPoint = Target.GetPosition(model)
    if not targetPart or not shootPart or not targetPoint then
        return false
    end

    local origin = shootPart.Position
    if shootPart:FindFirstChild("UseCamera") and Workspace.CurrentCamera then
        origin = Workspace.CurrentCamera.CFrame.Position
    end

    local aimPoint = targetPoint
    if type(State.CalculateArcTarget) == "function" then
        local arcOk, arcPoint = pcall(State.CalculateArcTarget, State.WeaponModel, targetPoint)
        if arcOk and typeof(arcPoint) == "Vector3" then
            aimPoint = arcPoint
        end
    end

    local targetParts = nil
    if type(State.LockController) == "table"
    and type(State.LockController.GetTargetParts) == "function" then
        local partsOk, parts = pcall(State.LockController.GetTargetParts, State.LockController)
        if partsOk then
            targetParts = parts
        end
    end

    local normal = origin - targetPoint
    normal = normal.Magnitude > 0.01 and normal.Unit or Vector3.new(0, 1, 0)

    State.FireRemote:FireServer(1, aimPoint, 1)
    State.FireRemote:FireServer(
        2,
        targetPoint,
        origin,
        targetPart,
        targetPoint,
        normal,
        targetParts
    )

    if ammo ~= nil
    and not State.WeaponModel:GetAttribute("ManuallyDeductedAmmo") then
        State.AmmoInfo.Ammo.Value = math.max(0, ammo - 1)
        if type(State.AmmoChanged) == "function" then
            pcall(State.AmmoChanged)
        end
    end

    State.LastFire = os.clock()
    return true
end

function Weapon.ClearFInput()
    State.FPress = nil
    State.FRelease = nil
    State.FTap = nil
    State.FInputMode = nil
end

function Weapon.ResolveFInput()
    -- F가 켜질 때만 실행기 입력 함수를 확인합니다.
    local environment = type(getgenv) == "function" and getgenv() or _G
    local press = rawget(environment, "keypress") or keypress
    local release = rawget(environment, "keyrelease") or keyrelease
    local tap = rawget(environment, "keytap") or keytap

    if type(press) == "function" and type(release) == "function" then
        State.FPress = press
        State.FRelease = release
        State.FInputMode = "press-release"
        return true
    end
    if type(tap) == "function" then
        State.FTap = tap
        State.FInputMode = "tap"
        return true
    end

    Weapon.ClearFInput()
    return false, "실행기에서 keypress/keyrelease 또는 keytap 함수를 찾지 못했습니다."
end

function Weapon.IsSecondaryFunction(fn, readConstants)
    local ok, constants = pcall(readConstants, fn)
    if not ok or type(constants) ~= "table" then return false end
    local found = {Secondary = false, GetTargetParts = false, FireServer = false, ScreenPointToRay = false}
    for _, value in pairs(constants) do
        if found[value] ~= nil then found[value] = true end
    end
    return found.Secondary and found.GetTargetParts and found.FireServer and found.ScreenPointToRay
end

function Weapon.ResolveSecondary()
    State.SecondaryAvailable = false
    State.SecondaryMode = "지원되지 않음"
    State.SecondaryRemote = nil
    State.SecondaryVehicle = nil
    State.SecondaryController = nil
    State.SecondaryLockPart = nil

    local vehicle = Weapon.GetSeatedVehicle()
    if not vehicle then
        return false, "현재 탑승 차량을 확인하지 못했습니다."
    end
    local remote = vehicle:FindFirstChild("Fire", true)
    local lockPart = vehicle:FindFirstChild("Lockon", true)
    if not remote or not remote:IsA("RemoteEvent") or not lockPart then
        return false, "현재 차량에 공통 F 유도미사일용 Fire/Lockon 객체가 없습니다."
    end
    State.SecondaryRemote = remote
    State.SecondaryVehicle = vehicle
    State.SecondaryLockPart = lockPart
    State.SecondaryInterval = Config.FUseInterval
    local events = ReplicatedStorage:FindFirstChild("Events")
    State.LockingEvent = events and events:FindFirstChild("LockingEvent")
    State.SecondaryMode = "직접 유도발사"
    State.SecondaryAvailable = true
    return true
end

function Weapon.ReleaseF()
    if not State.FKeyDown then
        return
    end
    State.FKeyDown = false
    if type(State.FRelease) == "function" then
        pcall(State.FRelease, 0x46)
    end
end

function Weapon.ClearImmediateLock()
    local controller = State.LockController
    local targets = controller and controller.CurrentTargets
    if type(targets) == "table"
    and State.FInjectedTarget
    and targets[1] == State.FInjectedTarget then
        table.clear(targets)
    end
    if controller and State.FPreviousIsLocking ~= nil then
        controller._IsLocking = State.FPreviousIsLocking
    end
    State.FInjectedTarget = nil
    State.FPreviousIsLocking = nil
end

function Weapon.SetImmediateLock(model)
    local controller = State.LockController
    if type(controller) ~= "table" then
        error("LockOnController를 찾지 못했습니다.")
    end
    if not model or not model.Parent then
        error("즉시 락온할 대상이 없습니다.")
    end

    local targets = controller.CurrentTargets
    if type(targets) ~= "table" then
        targets = {}
        controller.CurrentTargets = targets
    end

    if State.FInjectedTarget == nil then
        State.FPreviousIsLocking = controller._IsLocking
    end
    table.clear(targets)
    targets[1] = model
    controller._IsLocking = true
    State.FInjectedTarget = model

    if type(controller.GetTargetParts) == "function" then
        local ok, parts = pcall(controller.GetTargetParts, controller)
        if not ok or type(parts) ~= "table" or not parts[1] then
            error("락온 대상 부품을 만들지 못했습니다: " .. tostring(parts))
        end
    end
end

function Weapon.UseF(model)
    if not State.FAutoEnabled or not State.Running or not model then
        return false
    end
    if not State.SecondaryAvailable or not State.SecondaryRemote then
        error("F 직접 유도발사 구조가 준비되지 않았습니다.")
    end
    if os.clock() - State.LastFUse < math.max(Config.FUseInterval, State.SecondaryInterval or 0) then
        return false
    end
    local targetPart = Target.GetAimPart(model)
    local targetPoint = Target.GetPosition(model)
    if not targetPart or not targetPoint then return false end
    if State.LockingEvent and State.LockingEvent:IsA("RemoteEvent") then
        State.LockingEvent:FireServer(model)
    end
    State.SecondaryRemote:FireServer("Secondary", targetPoint, {targetPart})
    State.LastFUse = os.clock()
    return true
end

function Farm.AddLog(text)
    if not UI.LogBox then
        return
    end
    local line = string.format("[%s] %s", os.date("%H:%M:%S"), tostring(text))
    UI.LogBox.Text = UI.LogBox.Text == "" and line or (UI.LogBox.Text .. "\n" .. line)
    if #UI.LogBox.Text > 8000 then
        UI.LogBox.Text = UI.LogBox.Text:sub(-8000)
    end
    UI.LogBox.CursorPosition = #UI.LogBox.Text + 1
end

function Farm.CopyLog()
    if UI.LogBox and type(setclipboard) == "function" then
        setclipboard(UI.LogBox.Text)
        Farm.SetStatus("오류 로그를 클립보드에 복사했습니다.", State.Running)
    else
        Farm.SetStatus("로그 상자를 클릭한 뒤 Ctrl+A, Ctrl+C로 복사하세요.", State.Running)
    end
end

function Work.GetElapsed()
    local elapsed = State.WorkElapsed
    if State.WorkStartedAt then
        elapsed = elapsed + (os.clock() - State.WorkStartedAt)
    end
    return math.max(0, math.floor(elapsed))
end

function Work.Refresh()
    if not UI.WorkTime then return end
    local seconds = Work.GetElapsed()
    UI.WorkTime.Text = string.format(
        "작업시간 %02d:%02d:%02d",
        math.floor(seconds / 3600),
        math.floor((seconds % 3600) / 60),
        seconds % 60
    )
end

function Work.Start(reset)
    if reset then
        State.WorkElapsed = 0
        State.WorkStartedAt = nil
        State.FarmStartedUnix = os.time()
    end
    if not State.WorkStartedAt then
        State.WorkStartedAt = os.clock()
    end
    Work.Refresh()
end

function Work.Pause()
    if State.WorkStartedAt then
        State.WorkElapsed = State.WorkElapsed + (os.clock() - State.WorkStartedAt)
        State.WorkStartedAt = nil
    end
    Work.Refresh()
end

function Farm.SetStatus(text, active)
    if UI.Status then
        UI.Status.Text = text
    end
    if UI.Start then
        UI.Start.Text = active and "자동공격 작동 중" or "자동공격 시작"
        UI.Start.BackgroundColor3 = active
            and Color3.fromRGB(50, 125, 80)
            or Color3.fromRGB(55, 105, 165)
    end
end

function Farm.ApplyRange()
    local text = UI.RangeBox and UI.RangeBox.Text or ""
    local number = tonumber((text:gsub(",", "")))
    if not number then
        UI.RangeBox.Text = tostring(Config.MaxTargetDistance)
        Farm.SetStatus("범위에는 숫자만 입력하세요.", State.Running)
        return
    end

    Config.MaxTargetDistance = math.clamp(math.floor(number), 100, 10000)
    UI.RangeBox.Text = tostring(Config.MaxTargetDistance)
    Farm.SetStatus("공격 범위를 " .. Config.MaxTargetDistance .. "으로 적용했습니다.", State.Running)
end

function Farm.RefreshPrimaryButton()
    if not UI.PrimaryToggle then
        return
    end
    UI.PrimaryToggle.Text = State.PrimaryEnabled and "좌클릭: 켜짐" or "좌클릭: 꺼짐"
    UI.PrimaryToggle.BackgroundColor3 = State.PrimaryEnabled
        and Color3.fromRGB(50, 125, 80)
        or Color3.fromRGB(155, 65, 65)
end

function Farm.TogglePrimary()
    State.PrimaryEnabled = not State.PrimaryEnabled
    State.LastFire = 0
    State.PrimaryTarget = nil
    State.PrimaryAttackCount = 0
    Farm.RefreshPrimaryButton()
    local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
    if Bridge and type(Bridge.OnRecoveryStateChanged) == "function" then Bridge.OnRecoveryStateChanged("좌클릭 설정 변경") end
end

function Farm.RefreshFButton()
    if not UI.FToggle then
        return
    end
    UI.FToggle.Text = State.FAutoEnabled and "F 자동사용: 켜짐" or "F 자동사용: 꺼짐"
    UI.FToggle.BackgroundColor3 = State.FAutoEnabled
        and Color3.fromRGB(50, 125, 80)
        or Color3.fromRGB(155, 65, 65)
end

function Farm.ToggleF()
    if State.FAutoEnabled then
        State.FAutoEnabled = false
        State.LastFUse = 0
        State.FTarget = nil
        State.FAttackCount = 0
        Weapon.ReleaseF()
        Weapon.ClearImmediateLock()
        Weapon.ClearFInput()
        Farm.RefreshFButton()
        local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
        if Bridge and type(Bridge.OnRecoveryStateChanged) == "function" then Bridge.OnRecoveryStateChanged("F 설정 변경") end
        return
    end

    local ok, message = Weapon.ResolveSecondary()
    if not ok then
        State.FAutoEnabled = false
        Farm.AddLog("F 직접 유도 준비 실패: " .. tostring(message))
        Farm.RefreshFButton()
        Farm.SetStatus("F 직접 유도 준비 실패 · F만 꺼졌습니다.", State.Running)
        return
    end

    State.FAutoEnabled = true
    State.LastFUse = 0
    Farm.RefreshFButton()
    local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
    if Bridge and type(Bridge.OnRecoveryStateChanged) == "function" then Bridge.OnRecoveryStateChanged("F 설정 변경") end
end

function Farm.Stop(reason)
    local WasRunning = State.Running
    Work.Pause()
    Route.Stop()
    State.Running = false
    State.CurrentTarget = nil
    State.PrimaryTarget = nil
    State.FTarget = nil
    State.PrimaryAttackCount = 0
    State.FAttackCount = 0
    State.AssignmentTurn = "Primary"
    State.CurrentDistance = nil
    State.ReloadRequested = false
    State.LastFUse = 0
    Weapon.ReleaseF()
    Weapon.ClearImmediateLock()
    Farm.SetStatus(reason or "정지됨", false)

    local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
    if WasRunning and Bridge and type(Bridge.OnFarmStopped) == "function" then
        Bridge.OnFarmStopped(reason)
    end
end

function Farm.Start()
    if State.Running then
        return false
    end

    local character = Player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid or not humanoid.SeatPart then
        Farm.SetStatus("공격에 사용할 차량에 먼저 탑승하세요.", false)
        return false
    end

    local primaryOk, primaryMessage = true, nil
    if State.PrimaryEnabled then
        primaryOk, primaryMessage = Weapon.Resolve()
        if not primaryOk then
            Farm.AddLog("좌클릭 준비 실패: " .. tostring(primaryMessage))
        end
    end
    if State.FAutoEnabled then
        local fOk, fMessage = Weapon.ResolveSecondary()
        if not fOk then
            State.FAutoEnabled = false
            Farm.AddLog("F 직접 유도 준비 실패: " .. tostring(fMessage))
            Farm.RefreshFButton()
        end
    end

    State.LastFire = 0
    State.ReloadRequested = false
    State.Running = true
    if type(SaveFarmRecoveryDirect) == "function" then SaveFarmRecoveryDirect("공격 시작") end
    Route.Start()
    Farm.SetStatus(primaryOk
        and ("대상 탐색 중 · 좌클릭 " .. State.PrimaryMode)
        or "좌클릭 지원 안 됨 · F 공격과 이동은 계속", true)

    local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
    if Bridge and type(Bridge.OnFarmStarted) == "function" then
        Bridge.OnFarmStarted()
    end
    return true
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "ShowTimeAutoFarmV13"
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(580, 430)
Main.Position = UDim2.fromOffset(0, 0)
Main.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
Main.BorderSizePixel = 0
Main.Active = false
Main.Draggable = false
Main.Parent = IntegratedHost

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 9)
Corner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -58, 0, 34)
Title.Position = UDim2.fromOffset(12, 4)
Title.BackgroundTransparency = 1
Title.Text = "쇼타임 모바일 V3.9 시험본"
Title.TextColor3 = Color3.fromRGB(245, 245, 245)
Title.TextSize = 17
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(34, 28)
Close.Position = UDim2.new(1, -42, 0, 7)
Close.BackgroundColor3 = Color3.fromRGB(145, 55, 55)
Close.BorderSizePixel = 0
Close.Text = "X"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.Font = Enum.Font.GothamBold
Close.Visible = true
Close.Parent = Main

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -24, 0, 36)
TabBar.Position = UDim2.fromOffset(12, 42)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Main

local AttackTabButton = Instance.new("TextButton")
AttackTabButton.Size = UDim2.new(1/3, -4, 1, 0)
AttackTabButton.Position = UDim2.fromOffset(0, 0)
AttackTabButton.Text = "자동공격"
AttackTabButton.TextSize = 14
AttackTabButton.Font = Enum.Font.GothamBold
AttackTabButton.TextColor3 = Color3.new(1, 1, 1)
AttackTabButton.BorderSizePixel = 0
AttackTabButton.Parent = TabBar

local SettingsTabButton = Instance.new("TextButton")
SettingsTabButton.Size = UDim2.new(1/3, -4, 1, 0)
SettingsTabButton.Position = UDim2.new(1/3, 2, 0, 0)
SettingsTabButton.Text = "설정"
SettingsTabButton.TextSize = 14
SettingsTabButton.Font = Enum.Font.GothamBold
SettingsTabButton.TextColor3 = Color3.new(1, 1, 1)
SettingsTabButton.BorderSizePixel = 0
SettingsTabButton.Parent = TabBar

local OtherTabButton = Instance.new("TextButton")
OtherTabButton.Size = UDim2.new(1/3, -4, 1, 0)
OtherTabButton.Position = UDim2.new(2/3, 4, 0, 0)
OtherTabButton.Text = "기타"
OtherTabButton.TextSize = 14
OtherTabButton.Font = Enum.Font.GothamBold
OtherTabButton.TextColor3 = Color3.new(1, 1, 1)
OtherTabButton.BorderSizePixel = 0
OtherTabButton.Parent = TabBar

local AttackPanel = Instance.new("Frame")
AttackPanel.Size = UDim2.new(1, -24, 0, 338)
AttackPanel.Position = UDim2.fromOffset(12, 84)
AttackPanel.BackgroundTransparency = 1
AttackPanel.Parent = Main

local SettingsPanel = Instance.new("Frame")
SettingsPanel.Size = UDim2.new(1, -24, 0, 178)
SettingsPanel.Position = AttackPanel.Position
SettingsPanel.BackgroundTransparency = 1
SettingsPanel.Visible = false
SettingsPanel.Parent = Main

local OtherPanel = Instance.new("Frame")
OtherPanel.Size = UDim2.new(1, -24, 0, 408)
OtherPanel.Position = AttackPanel.Position
OtherPanel.BackgroundTransparency = 1
OtherPanel.Visible = false
OtherPanel.Parent = Main

UI.Status = Instance.new("TextLabel")
local VehicleCard = Instance.new("Frame")
VehicleCard.Size = UDim2.new(0.5, -5, 0, 132)
VehicleCard.Position = UDim2.fromOffset(0, 4)
VehicleCard.BackgroundColor3 = Color3.fromRGB(31, 31, 38)
VehicleCard.BorderSizePixel = 0
VehicleCard.Parent = AttackPanel

UI.VehicleImage = Instance.new("ImageLabel")
UI.VehicleImage.Size = UDim2.fromOffset(104, 82)
UI.VehicleImage.Position = UDim2.fromOffset(8, 8)
UI.VehicleImage.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
UI.VehicleImage.BorderSizePixel = 0
UI.VehicleImage.Image = ""
UI.VehicleImage.ScaleType = Enum.ScaleType.Fit
UI.VehicleImage.Parent = VehicleCard

UI.VehicleName = Instance.new("TextLabel")
UI.VehicleName.Size = UDim2.new(1, -128, 0, 30)
UI.VehicleName.Position = UDim2.fromOffset(120, 10)
UI.VehicleName.BackgroundTransparency = 1
UI.VehicleName.Text = "선택 차량 없음"
UI.VehicleName.TextColor3 = Color3.fromRGB(245, 245, 245)
UI.VehicleName.TextSize = 17
UI.VehicleName.Font = Enum.Font.GothamBold
UI.VehicleName.TextXAlignment = Enum.TextXAlignment.Left
UI.VehicleName.Parent = VehicleCard

UI.VehicleInfo = Instance.new("TextLabel")
UI.VehicleInfo.Size = UDim2.new(1, -128, 0, 46)
UI.VehicleInfo.Position = UDim2.fromOffset(120, 40)
UI.VehicleInfo.BackgroundTransparency = 1
UI.VehicleInfo.Text = "레벨 - · 별 -"
UI.VehicleInfo.TextColor3 = Color3.fromRGB(195, 195, 205)
UI.VehicleInfo.TextSize = 14
UI.VehicleInfo.TextWrapped = true
UI.VehicleInfo.Font = Enum.Font.Gotham
UI.VehicleInfo.TextXAlignment = Enum.TextXAlignment.Left
UI.VehicleInfo.TextYAlignment = Enum.TextYAlignment.Top
UI.VehicleInfo.Parent = VehicleCard

UI.WorkTime = Instance.new("TextLabel")
UI.WorkTime.Size = UDim2.new(0.58, -10, 0, 28)
UI.WorkTime.Position = UDim2.fromOffset(8, 96)
UI.WorkTime.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
UI.WorkTime.BorderSizePixel = 0
UI.WorkTime.Text = "작업시간 00:00:00"
UI.WorkTime.TextColor3 = Color3.fromRGB(225, 225, 235)
UI.WorkTime.TextSize = 14
UI.WorkTime.Font = Enum.Font.GothamBold
UI.WorkTime.Parent = VehicleCard

UI.RespawnCount = Instance.new("TextLabel")
UI.RespawnCount.Size = UDim2.new(0.42, -10, 0, 28)
UI.RespawnCount.Position = UDim2.new(0.58, 2, 0, 96)
UI.RespawnCount.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
UI.RespawnCount.BorderSizePixel = 0
UI.RespawnCount.Text = "재소환 0회"
UI.RespawnCount.TextColor3 = Color3.fromRGB(225, 225, 235)
UI.RespawnCount.TextSize = 13
UI.RespawnCount.Font = Enum.Font.GothamBold
UI.RespawnCount.Parent = VehicleCard

UI.Status.Size = UDim2.new(0.5, -5, 0, 132)
UI.Status.Position = UDim2.new(0.5, 5, 0, 4)
UI.Status.BackgroundColor3 = Color3.fromRGB(31, 31, 38)
UI.Status.BorderSizePixel = 0
UI.Status.Text = "보유차량에서 차량을 선택·소환한 뒤\n자동공격 시작을 누르세요."
UI.Status.TextColor3 = Color3.fromRGB(225, 225, 230)
UI.Status.TextSize = 15
UI.Status.Font = Enum.Font.Gotham
UI.Status.TextWrapped = true
UI.Status.Parent = AttackPanel

UI.PrimaryToggle = Instance.new("TextButton")
UI.PrimaryToggle.Size = UDim2.new(1 / 3, -4, 0, 40)
UI.PrimaryToggle.Position = UDim2.fromOffset(0, 146)
UI.PrimaryToggle.BorderSizePixel = 0
UI.PrimaryToggle.TextColor3 = Color3.new(1, 1, 1)
UI.PrimaryToggle.Font = Enum.Font.GothamBold
UI.PrimaryToggle.TextSize = 14
UI.PrimaryToggle.Parent = AttackPanel
Farm.RefreshPrimaryButton()

UI.FToggle = Instance.new("TextButton")
UI.FToggle.Size = UDim2.new(1 / 3, -4, 0, 40)
UI.FToggle.Position = UDim2.new(1 / 3, 2, 0, 146)
UI.FToggle.BorderSizePixel = 0
UI.FToggle.TextColor3 = Color3.new(1, 1, 1)
UI.FToggle.Font = Enum.Font.GothamBold
UI.FToggle.TextSize = 14
UI.FToggle.Parent = AttackPanel
Farm.RefreshFButton()

local RangeLabel = Instance.new("TextLabel")
RangeLabel.Size = UDim2.fromOffset(72, 32)
RangeLabel.Position = UDim2.fromOffset(0, 24)
RangeLabel.BackgroundTransparency = 1
RangeLabel.Text = "공격 범위"
RangeLabel.TextColor3 = Color3.fromRGB(220, 220, 225)
RangeLabel.TextSize = 14
RangeLabel.Font = Enum.Font.GothamBold
RangeLabel.TextXAlignment = Enum.TextXAlignment.Left
RangeLabel.Parent = SettingsPanel

UI.RangeBox = Instance.new("TextBox")
UI.RangeBox.Size = UDim2.fromOffset(150, 32)
UI.RangeBox.Position = UDim2.fromOffset(96, 18)
UI.RangeBox.BackgroundColor3 = Color3.fromRGB(39, 39, 47)
UI.RangeBox.BorderSizePixel = 0
UI.RangeBox.ClearTextOnFocus = false
UI.RangeBox.Text = tostring(Config.MaxTargetDistance)
UI.RangeBox.PlaceholderText = "100~10000"
UI.RangeBox.TextColor3 = Color3.fromRGB(245, 245, 245)
UI.RangeBox.TextSize = 14
UI.RangeBox.Font = Enum.Font.GothamBold
UI.RangeBox.Parent = SettingsPanel

local ApplyRange = Instance.new("TextButton")
ApplyRange.Size = UDim2.fromOffset(132, 32)
ApplyRange.Position = UDim2.fromOffset(258, 18)
ApplyRange.BackgroundColor3 = Color3.fromRGB(67, 67, 78)
ApplyRange.BorderSizePixel = 0
ApplyRange.Text = "범위 적용"
ApplyRange.TextColor3 = Color3.new(1, 1, 1)
ApplyRange.Font = Enum.Font.GothamBold
ApplyRange.TextSize = 14
ApplyRange.Parent = SettingsPanel

local RouteLabel = Instance.new("TextLabel")
RouteLabel.Size = UDim2.fromOffset(72, 32)
RouteLabel.Position = UDim2.fromOffset(0, 66)
RouteLabel.BackgroundTransparency = 1
RouteLabel.Text = "경로 이동"
RouteLabel.TextColor3 = Color3.fromRGB(220, 220, 225)
RouteLabel.TextSize = 14
RouteLabel.Font = Enum.Font.GothamBold
RouteLabel.TextXAlignment = Enum.TextXAlignment.Left
RouteLabel.Parent = SettingsPanel

UI.RouteToggle = Instance.new("TextButton")
UI.RouteToggle.Size = UDim2.fromOffset(150, 32)
UI.RouteToggle.Position = UDim2.fromOffset(96, 66)
UI.RouteToggle.BorderSizePixel = 0
UI.RouteToggle.TextColor3 = Color3.new(1, 1, 1)
UI.RouteToggle.TextSize = 14
UI.RouteToggle.Font = Enum.Font.GothamBold
UI.RouteToggle.Parent = SettingsPanel
Route.RefreshButton()
UI.RouteToggle.MouseButton1Click:Connect(Route.Toggle)

local SettingsGuide = Instance.new("TextLabel")
SettingsGuide.Size = UDim2.new(1, 0, 0, 80)
SettingsGuide.Position = UDim2.fromOffset(0, 112)
SettingsGuide.BackgroundColor3 = Color3.fromRGB(31, 31, 38)
SettingsGuide.BorderSizePixel = 0
SettingsGuide.Text = "경로: 높이 1,000 · 속도 200 · 가장 가까운 지점부터 12개 좌표 반복\n공격 범위 기본값은 5,000이며 좌클릭 속도에는 영향을 주지 않습니다."
SettingsGuide.TextColor3 = Color3.fromRGB(215, 215, 225)
SettingsGuide.TextSize = 14
SettingsGuide.TextWrapped = true
SettingsGuide.Font = Enum.Font.Gotham
SettingsGuide.Parent = SettingsPanel

UI.DiscordTitle = Instance.new("TextLabel")
UI.DiscordTitle.Size = UDim2.new(1, 0, 0, 24)
UI.DiscordTitle.Position = UDim2.fromOffset(0, 202)
UI.DiscordTitle.BackgroundTransparency = 1
UI.DiscordTitle.Text = "디스코드 알림 설정 · 목표 레벨은 차량 선택창에서 지정"
UI.DiscordTitle.TextColor3 = Color3.fromRGB(235, 235, 240)
UI.DiscordTitle.TextSize = 14
UI.DiscordTitle.Font = Enum.Font.GothamBold
UI.DiscordTitle.TextXAlignment = Enum.TextXAlignment.Left
UI.DiscordTitle.Parent = SettingsPanel

UI.WebhookBox = Instance.new("TextBox")
UI.WebhookBox.Size = UDim2.new(1, -142, 0, 34)
UI.WebhookBox.Position = UDim2.fromOffset(0, 234)
UI.WebhookBox.BackgroundColor3 = Color3.fromRGB(39, 39, 47)
UI.WebhookBox.BorderSizePixel = 0
UI.WebhookBox.ClearTextOnFocus = false
UI.WebhookBox.Text = ""
UI.WebhookBox.PlaceholderText = State.DiscordWebhook ~= ""
    and "웹훅 저장됨 · 변경할 때만 새 주소 입력"
    or "디스코드 웹훅 주소 붙여넣기"
UI.WebhookBox.TextColor3 = Color3.fromRGB(245, 245, 245)
UI.WebhookBox.TextSize = 12
UI.WebhookBox.TextWrapped = false
UI.WebhookBox.ClipsDescendants = true
UI.WebhookBox.Font = Enum.Font.Code
UI.WebhookBox.TextXAlignment = Enum.TextXAlignment.Left
UI.WebhookBox.Parent = SettingsPanel

UI.SaveWebhook = Instance.new("TextButton")
UI.SaveWebhook.Size = UDim2.fromOffset(132, 34)
UI.SaveWebhook.Position = UDim2.new(1, -132, 0, 234)
UI.SaveWebhook.BackgroundColor3 = Color3.fromRGB(65, 80, 105)
UI.SaveWebhook.BorderSizePixel = 0
UI.SaveWebhook.Text = "웹훅 저장"
UI.SaveWebhook.TextColor3 = Color3.new(1, 1, 1)
UI.SaveWebhook.TextSize = 14
UI.SaveWebhook.Font = Enum.Font.GothamBold
UI.SaveWebhook.Parent = SettingsPanel

UI.DiscordToggle = Instance.new("TextButton")
UI.DiscordToggle.Size = UDim2.new(0.5, -5, 0, 36)
UI.DiscordToggle.Position = UDim2.fromOffset(0, 278)
UI.DiscordToggle.BorderSizePixel = 0
UI.DiscordToggle.TextColor3 = Color3.new(1, 1, 1)
UI.DiscordToggle.TextSize = 14
UI.DiscordToggle.Font = Enum.Font.GothamBold
UI.DiscordToggle.Parent = SettingsPanel

UI.TestWebhook = Instance.new("TextButton")
UI.TestWebhook.Size = UDim2.new(0.5, -5, 0, 36)
UI.TestWebhook.Position = UDim2.new(0.5, 5, 0, 278)
UI.TestWebhook.BackgroundColor3 = Color3.fromRGB(55, 105, 165)
UI.TestWebhook.BorderSizePixel = 0
UI.TestWebhook.Text = "전송 시험"
UI.TestWebhook.TextColor3 = Color3.new(1, 1, 1)
UI.TestWebhook.TextSize = 14
UI.TestWebhook.Font = Enum.Font.GothamBold
UI.TestWebhook.Parent = SettingsPanel

UI.DiscordStatus = Instance.new("TextLabel")
UI.DiscordStatus.Size = UDim2.new(1, 0, 0, 54)
UI.DiscordStatus.Position = UDim2.fromOffset(0, 324)
UI.DiscordStatus.BackgroundColor3 = Color3.fromRGB(31, 31, 38)
UI.DiscordStatus.BorderSizePixel = 0
UI.DiscordStatus.Text = State.DiscordStatus
UI.DiscordStatus.TextColor3 = Color3.fromRGB(215, 215, 225)
UI.DiscordStatus.TextSize = 13
UI.DiscordStatus.TextWrapped = true
UI.DiscordStatus.Font = Enum.Font.Gotham
UI.DiscordStatus.Parent = SettingsPanel

function Discord.RefreshToggle()
    UI.DiscordToggle.Text = State.DiscordEnabled and "레벨 100 알림: 켜짐" or "레벨 100 알림: 꺼짐"
    UI.DiscordToggle.BackgroundColor3 = State.DiscordEnabled and Color3.fromRGB(50, 135, 82) or Color3.fromRGB(88, 88, 98)
end
Discord.RefreshToggle()

UI.SaveWebhook.MouseButton1Click:Connect(function()
    if UI.WebhookBox.Text ~= "" then
        State.DiscordWebhook = UI.WebhookBox.Text
        UI.WebhookBox.Text = ""
        UI.WebhookBox.PlaceholderText = "웹훅 저장됨 · 변경할 때만 새 주소 입력"
    end
    Discord.SaveConfig()
end)
UI.TestWebhook.MouseButton1Click:Connect(Discord.Test)
UI.DiscordToggle.MouseButton1Click:Connect(function()
    State.DiscordEnabled = not State.DiscordEnabled
    Discord.RefreshToggle()
    Discord.SaveConfig()
end)

UI.Start = Instance.new("TextButton")
UI.Start.Size = UDim2.new(0.5, -5, 0, 40)
UI.Start.Position = UDim2.fromOffset(0, 196)
UI.Start.BackgroundColor3 = Color3.fromRGB(55, 105, 165)
UI.Start.BorderSizePixel = 0
UI.Start.Text = "자동공격 시작"
UI.Start.TextColor3 = Color3.new(1, 1, 1)
UI.Start.Font = Enum.Font.GothamBold
UI.Start.TextSize = 14
UI.Start.Parent = AttackPanel

local Stop = Instance.new("TextButton")
Stop.Size = UDim2.new(0.5, -5, 0, 40)
Stop.Position = UDim2.new(0.5, 5, 0, 196)
Stop.BackgroundColor3 = Color3.fromRGB(145, 65, 60)
Stop.BorderSizePixel = 0
Stop.Text = "정지 (F5)"
Stop.TextColor3 = Color3.new(1, 1, 1)
Stop.Font = Enum.Font.GothamBold
Stop.TextSize = 14
Stop.Parent = AttackPanel

local OpenVehicles = Instance.new("TextButton")
OpenVehicles.Size = UDim2.new(1, 0, 0, 44)
OpenVehicles.Position = UDim2.fromOffset(0, 246)
OpenVehicles.BackgroundColor3 = Color3.fromRGB(62, 82, 118)
OpenVehicles.BorderSizePixel = 0
OpenVehicles.Text = "보유차량 선택·소환 열기"
OpenVehicles.TextColor3 = Color3.new(1, 1, 1)
OpenVehicles.TextSize = 15
OpenVehicles.Font = Enum.Font.GothamBold
OpenVehicles.Parent = AttackPanel

local AttackDetailButton = Instance.new("TextButton")
AttackDetailButton.Size = UDim2.new(1 / 3, -4, 0, 40)
AttackDetailButton.Position = UDim2.new(2 / 3, 4, 0, 146)
AttackDetailButton.BackgroundColor3 = Color3.fromRGB(60, 68, 88)
AttackDetailButton.BorderSizePixel = 0
AttackDetailButton.Text = "공격 상세 설정"
AttackDetailButton.TextColor3 = Color3.new(1, 1, 1)
AttackDetailButton.TextSize = 13
AttackDetailButton.Font = Enum.Font.GothamBold
AttackDetailButton.Parent = AttackPanel

local AttackDetail = Instance.new("Frame")
AttackDetail.Size = UDim2.fromOffset(450, 420)
AttackDetail.Position = UDim2.new(0.5, -225, 0.5, -210)
AttackDetail.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
AttackDetail.BorderSizePixel = 0
AttackDetail.Visible = false
AttackDetail.ZIndex = 120
AttackDetail.Parent = Gui
local DetailCorner = Instance.new("UICorner")
DetailCorner.CornerRadius = UDim.new(0, 8)
DetailCorner.Parent = AttackDetail

local function detailControl(text, x, y, w, h)
    local button = Instance.new("TextButton")
    button.Size = UDim2.fromOffset(w, h or 32)
    button.Position = UDim2.fromOffset(x, y)
    button.BackgroundColor3 = Color3.fromRGB(55, 62, 78)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 12
    button.Font = Enum.Font.GothamBold
    button.ZIndex = 121
    button.Parent = AttackDetail
    return button
end

local DetailTitle = Instance.new("TextLabel")
DetailTitle.Size = UDim2.new(1, -60, 0, 34)
DetailTitle.Position = UDim2.fromOffset(14, 5)
DetailTitle.BackgroundTransparency = 1
DetailTitle.Text = "공격 상세 설정"
DetailTitle.TextColor3 = Color3.new(1, 1, 1)
DetailTitle.TextSize = 16
DetailTitle.Font = Enum.Font.GothamBold
DetailTitle.TextXAlignment = Enum.TextXAlignment.Left
DetailTitle.ZIndex = 121
DetailTitle.Parent = AttackDetail
local DetailClose = detailControl("X", 405, 7, 32, 28)

local BoatToggle = detailControl("", 14, 48, 422, 32)
local BoatPrimary = detailControl("", 14, 86, 206, 32)
local BoatF = detailControl("", 230, 86, 206, 32)
local F35Primary = detailControl("", 14, 124, 206, 32)
local F35F = detailControl("", 230, 124, 206, 32)
local PrimaryMode = detailControl("", 14, 170, 206, 32)
local FMode = detailControl("", 230, 170, 206, 32)
local PrimaryMinus = detailControl("-", 14, 208, 42, 32)
local PrimaryCount = detailControl("", 62, 208, 110, 32)
local PrimaryPlus = detailControl("+", 178, 208, 42, 32)
local FMinus = detailControl("-", 230, 208, 42, 32)
local FCount = detailControl("", 278, 208, 110, 32)
local FPlus = detailControl("+", 394, 208, 42, 32)
local PrimaryFamily = detailControl("", 14, 256, 422, 34)

local CurrentModes = Instance.new("TextLabel")
CurrentModes.Size = UDim2.new(1, -28, 0, 72)
CurrentModes.Position = UDim2.fromOffset(14, 302)
CurrentModes.BackgroundColor3 = Color3.fromRGB(34, 34, 42)
CurrentModes.BorderSizePixel = 0
CurrentModes.TextColor3 = Color3.fromRGB(225, 225, 232)
CurrentModes.TextSize = 12
CurrentModes.TextWrapped = true
CurrentModes.Font = Enum.Font.Gotham
CurrentModes.ZIndex = 121
CurrentModes.Parent = AttackDetail

local function onOff(value) return value and "켜짐" or "꺼짐" end
local AttackDetailQueueIndex = nil
local AttackDetailPreviousSettings = nil

local function saveQueueAttackSettingsIfEditing()
    local entry = AttackDetailQueueIndex and Queue.Entries[AttackDetailQueueIndex]
    if not entry or type(CaptureAttackSettings) ~= "function" then return end
    entry.AttackSettings = CaptureAttackSettings()
    Queue.SuppressRecoverySync = true
    Queue.Save()
    Queue.SuppressRecoverySync = false
    Queue.Render()
    Status.Text = tostring(entry.Name) .. " · 차량별 공격 설정 저장 완료"
end

local function resetAttackAssignments()
    State.PrimaryTarget, State.FTarget = nil, nil
    State.PrimaryAttackCount, State.FAttackCount = 0, 0
    State.CurrentTarget = nil
    Weapon.ClearImmediateLock()
end
local function refreshAttackDetail()
    BoatToggle.Text = "NPC 보트 공격: " .. onOff(Config.AttackBoats)
    BoatPrimary.Text = "보트 좌클릭: " .. onOff(Config.PrimaryBoats)
    BoatF.Text = "보트 F: " .. onOff(Config.FBoats)
    F35Primary.Text = "F35 좌클릭: " .. onOff(Config.PrimaryF35)
    F35F.Text = "F35 F: " .. onOff(Config.FF35)
    PrimaryMode.Text = Config.PrimaryAttackLimit == 0 and "좌클릭 방식: 자동" or "좌클릭 방식: 횟수 사용"
    FMode.Text = Config.FAttackLimit == 0 and "F 방식: 자동" or "F 방식: 횟수 사용"
    PrimaryCount.Text = Config.PrimaryAttackLimit == 0 and "설정 안 함" or (Config.PrimaryAttackLimit .. "회")
    FCount.Text = Config.FAttackLimit == 0 and "설정 안 함" or (Config.FAttackLimit .. "회")
    PrimaryFamily.Text = Config.GuidedPrimaryFamily
        and "좌클릭 장비 유형: 슈레저형 유도탄"
        or "좌클릭 장비 유형: 일반 기관총 (기본)"
    PrimaryFamily.BackgroundColor3 = Config.GuidedPrimaryFamily
        and Color3.fromRGB(125, 78, 48)
        or Color3.fromRGB(55, 95, 135)
    local primaryVisible = Config.PrimaryAttackLimit > 0
    local fVisible = Config.FAttackLimit > 0
    PrimaryMinus.Visible, PrimaryCount.Visible, PrimaryPlus.Visible = primaryVisible, primaryVisible, primaryVisible
    FMinus.Visible, FCount.Visible, FPlus.Visible = fVisible, fVisible, fVisible
    CurrentModes.Text = "자동 = 대상 체력 0까지 공격 · 횟수 사용 = 설정 횟수 후 다음 표적\n현재 방식  좌클릭: "
        .. tostring(State.PrimaryMode) .. " / F: " .. tostring(State.SecondaryMode) .. "\n보트 기본: 좌클릭 켜짐 · F 꺼짐"
    saveQueueAttackSettingsIfEditing()
end

BoatToggle.MouseButton1Click:Connect(function() Config.AttackBoats = not Config.AttackBoats; resetAttackAssignments(); refreshAttackDetail() end)
BoatPrimary.MouseButton1Click:Connect(function() Config.PrimaryBoats = not Config.PrimaryBoats; resetAttackAssignments(); refreshAttackDetail() end)
BoatF.MouseButton1Click:Connect(function() Config.FBoats = not Config.FBoats; resetAttackAssignments(); refreshAttackDetail() end)
F35Primary.MouseButton1Click:Connect(function() Config.PrimaryF35 = not Config.PrimaryF35; resetAttackAssignments(); refreshAttackDetail() end)
F35F.MouseButton1Click:Connect(function() Config.FF35 = not Config.FF35; resetAttackAssignments(); refreshAttackDetail() end)
PrimaryMode.MouseButton1Click:Connect(function() Config.PrimaryAttackLimit = Config.PrimaryAttackLimit == 0 and 1 or 0; refreshAttackDetail() end)
FMode.MouseButton1Click:Connect(function() Config.FAttackLimit = Config.FAttackLimit == 0 and 1 or 0; refreshAttackDetail() end)
PrimaryMinus.MouseButton1Click:Connect(function() Config.PrimaryAttackLimit = math.max(0, Config.PrimaryAttackLimit - 1); refreshAttackDetail() end)
PrimaryPlus.MouseButton1Click:Connect(function() Config.PrimaryAttackLimit = math.min(20, Config.PrimaryAttackLimit + 1); refreshAttackDetail() end)
FMinus.MouseButton1Click:Connect(function() Config.FAttackLimit = math.max(0, Config.FAttackLimit - 1); refreshAttackDetail() end)
FPlus.MouseButton1Click:Connect(function() Config.FAttackLimit = math.min(20, Config.FAttackLimit + 1); refreshAttackDetail() end)
PrimaryFamily.MouseButton1Click:Connect(function()
    Config.GuidedPrimaryFamily = not Config.GuidedPrimaryFamily
    resetAttackAssignments()
    if State.Running and State.PrimaryEnabled then
        local ok, message = Weapon.Resolve()
        if not ok then Farm.AddLog("좌클릭 장비 유형 변경 실패: " .. tostring(message)) end
    end
    refreshAttackDetail()
    local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
    if Bridge and type(Bridge.OnRecoveryStateChanged) == "function" then Bridge.OnRecoveryStateChanged("공격 유형 변경") end
end)
OpenQueueAttackSettings = function(index)
    local entry = Queue.Entries[index]
    if not entry then return end
    AttackDetailPreviousSettings = CaptureAttackSettings()
    AttackDetailQueueIndex = index
    if type(entry.AttackSettings) ~= "table" then
        entry.AttackSettings = CaptureAttackSettings()
        Queue.Save()
    end
    ApplyAttackSettings(entry.AttackSettings)
    DetailTitle.Text = "대기열 " .. tostring(index) .. "번 · " .. tostring(entry.Name) .. " 공격 설정"
    AttackDetail.Visible = true
    refreshAttackDetail()
end

AttackDetailButton.MouseButton1Click:Connect(function()
    AttackDetailQueueIndex = nil
    AttackDetailPreviousSettings = nil
    DetailTitle.Text = "공격 상세 설정"
    AttackDetail.Visible = true
    refreshAttackDetail()
end)
DetailClose.MouseButton1Click:Connect(function()
    saveQueueAttackSettingsIfEditing()
    if AttackDetailQueueIndex and AttackDetailPreviousSettings then
        ApplyAttackSettings(AttackDetailPreviousSettings)
        resetAttackAssignments()
    end
    AttackDetailQueueIndex = nil
    AttackDetailPreviousSettings = nil
    DetailTitle.Text = "공격 상세 설정"
    AttackDetail.Visible = false
    refreshAttackDetail()
    local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
    if Bridge and type(Bridge.OnRecoveryStateChanged) == "function" then
        Bridge.OnRecoveryStateChanged("대기열 차량별 공격 설정 변경")
    end
end)
refreshAttackDetail()

local LogLabel = Instance.new("TextLabel")
LogLabel.Size = UDim2.new(1, -24, 0, 18)
LogLabel.Position = UDim2.fromOffset(0, 4)
LogLabel.BackgroundTransparency = 1
LogLabel.Text = "오류 로그 · 상자를 클릭하면 직접 선택/복사할 수 있습니다."
LogLabel.TextColor3 = Color3.fromRGB(220, 220, 225)
LogLabel.TextSize = 13
LogLabel.Font = Enum.Font.GothamBold
LogLabel.TextXAlignment = Enum.TextXAlignment.Left
LogLabel.Parent = OtherPanel

UI.LogBox = Instance.new("TextBox")
UI.LogBox.Size = UDim2.new(1, 0, 0, 280)
UI.LogBox.Position = UDim2.fromOffset(0, 30)
UI.LogBox.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
UI.LogBox.BorderSizePixel = 0
UI.LogBox.ClearTextOnFocus = false
UI.LogBox.MultiLine = true
UI.LogBox.TextEditable = false
UI.LogBox.Text = ""
UI.LogBox.PlaceholderText = "F 오류가 발생하면 여기에 계속 남습니다."
UI.LogBox.TextColor3 = Color3.fromRGB(235, 210, 150)
UI.LogBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 140)
UI.LogBox.TextSize = 13
UI.LogBox.Font = Enum.Font.Code
UI.LogBox.TextWrapped = true
UI.LogBox.TextXAlignment = Enum.TextXAlignment.Left
UI.LogBox.TextYAlignment = Enum.TextYAlignment.Top
UI.LogBox.Parent = OtherPanel

local CopyLog = Instance.new("TextButton")
CopyLog.Size = UDim2.new(1, 0, 0, 38)
CopyLog.Position = UDim2.fromOffset(0, 320)
CopyLog.BackgroundColor3 = Color3.fromRGB(65, 80, 105)
CopyLog.BorderSizePixel = 0
CopyLog.Text = "로그 전체 복사"
CopyLog.TextColor3 = Color3.new(1, 1, 1)
CopyLog.Font = Enum.Font.GothamBold
CopyLog.TextSize = 14
CopyLog.Parent = OtherPanel

local Hint = Instance.new("TextLabel")
Hint.Size = UDim2.new(1, -24, 0, 18)
Hint.Position = UDim2.fromOffset(0, 370)
Hint.BackgroundTransparency = 1
Hint.Text = "범위 100~10,000 · 기본 5,000 · 마우스/크로스헤드 고정"
Hint.TextColor3 = Color3.fromRGB(165, 165, 175)
Hint.TextSize = 13
Hint.Font = Enum.Font.Gotham
Hint.TextXAlignment = Enum.TextXAlignment.Left
Hint.Parent = OtherPanel

local function ShowTab(name)
    if name == "Attack" then
        Main.Size = UDim2.fromOffset(580, 430)
    elseif name == "Settings" then
        Main.Size = UDim2.fromOffset(580, 500)
    else
        Main.Size = UDim2.fromOffset(580, 500)
    end
    AttackPanel.Visible = name == "Attack"
    SettingsPanel.Visible = name == "Settings"
    OtherPanel.Visible = name == "Other"
    AttackTabButton.BackgroundColor3 = name == "Attack" and Color3.fromRGB(62, 82, 118) or Color3.fromRGB(46, 46, 53)
    SettingsTabButton.BackgroundColor3 = name == "Settings" and Color3.fromRGB(62, 82, 118) or Color3.fromRGB(46, 46, 53)
    OtherTabButton.BackgroundColor3 = name == "Other" and Color3.fromRGB(62, 82, 118) or Color3.fromRGB(46, 46, 53)
end

ShowTab("Attack")
AttackTabButton.MouseButton1Click:Connect(function() ShowTab("Attack") end)
SettingsTabButton.MouseButton1Click:Connect(function() ShowTab("Settings") end)
OtherTabButton.MouseButton1Click:Connect(function() ShowTab("Other") end)
OpenVehicles.MouseButton1Click:Connect(function()
    if type(OpenVehiclePopup) == "function" then
        OpenVehiclePopup()
    end
end)

UI.Start.MouseButton1Click:Connect(function()
    if type(StartIntegratedAttack) == "function" then
        StartIntegratedAttack(false)
    end
end)
UI.PrimaryToggle.MouseButton1Click:Connect(Farm.TogglePrimary)
UI.FToggle.MouseButton1Click:Connect(Farm.ToggleF)
ApplyRange.MouseButton1Click:Connect(Farm.ApplyRange)
CopyLog.MouseButton1Click:Connect(Farm.CopyLog)
UI.RangeBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        Farm.ApplyRange()
    end
end)
Stop.MouseButton1Click:Connect(function()
    local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
    if Bridge and type(Bridge.RequestStopConfirm) == "function" then
        Bridge.RequestStopConfirm()
        return
    end
    if type(SetVehicleWatchdogEnabled) == "function" then
        SetVehicleWatchdogEnabled(false)
    end
    Farm.Stop("사용자가 정지했습니다.")
end)
Close.MouseButton1Click:Connect(function()
    local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
    if Bridge and type(Bridge.ReturnToMain) == "function" then
        Gui.Enabled = false
        if Root and Root.Parent then
            Root.Visible = false
        end
        Bridge.ReturnToMain()
        return
    end
    if type(CloseIntegratedApplication) == "function" then
        CloseIntegratedApplication()
    else
        Farm.Stop("창을 닫았습니다.")
        Gui:Destroy()
    end
end)

table.insert(State.Connections, UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F5 then
        local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
        if Bridge and type(Bridge.ClearFarmRecovery) == "function" then Bridge.ClearFarmRecovery() end
        if type(SetVehicleWatchdogEnabled) == "function" then
            SetVehicleWatchdogEnabled(false)
        end
        Farm.Stop("F5 강제 정지 완료")
    end
end))

Target.BuildCache()

task.spawn(function()
    while Gui.Parent do
        Work.Refresh()
        task.wait(1)
    end
end)

task.spawn(function()
    while Gui.Parent do
        Discord.CheckLevel100()
        task.wait(1)
    end
end)

task.spawn(function()
    while Gui.Parent do
        if State.Running then
            if State.PrimaryTarget and not Target.IsAlive(State.PrimaryTarget) then
                State.PrimaryTarget, State.PrimaryAttackCount = nil, 0
            end
            if State.FTarget and not Target.IsAlive(State.FTarget) then
                State.FTarget, State.FAttackCount = nil, 0
                Weapon.ClearImmediateLock()
            end
            local excluded = os.clock() - State.LastReleasedAt < 1.5 and State.LastReleasedTarget or nil
            if not State.PrimaryTarget and State.PrimaryEnabled and State.PrimaryAvailable then
                local model, distance = Target.FindNearestForChannel("Primary", excluded)
                State.PrimaryTarget, State.CurrentDistance = model, distance
            end
            if not State.FTarget and State.FAutoEnabled and State.SecondaryAvailable then
                local model, distance = Target.FindNearestForChannel("F", excluded)
                State.FTarget = model
                State.CurrentDistance = State.CurrentDistance or distance
            end
            State.CurrentTarget = State.PrimaryTarget or State.FTarget
            if State.CurrentTarget then
                local channelName = State.PrimaryTarget and State.FTarget and "좌클릭+F"
                    or State.PrimaryTarget and "좌클릭"
                    or "F"
                Farm.SetStatus(string.format("%s 동시 사용 중: %s · 좌클릭 %s", channelName, State.CurrentTarget.Name, State.PrimaryMode), true)
            else
                Farm.SetStatus(string.format("%d 이내의 설정된 공격 대상 없음", Config.MaxTargetDistance), true)
            end
        end
        task.wait(Config.TargetRefreshInterval)
    end
end)

table.insert(State.Connections, RunService.Heartbeat:Connect(function(deltaTime)
    Route.Step(deltaTime)
    if not State.Running then return end
    if State.PrimaryEnabled and State.PrimaryAvailable
    and State.PrimaryTarget and Target.IsAlive(State.PrimaryTarget) then
        local ok, fired = pcall(Weapon.FireAt, State.PrimaryTarget)
        if ok and fired then
            State.PrimaryAttackCount += 1
            if Config.PrimaryAttackLimit > 0 and State.PrimaryAttackCount >= Config.PrimaryAttackLimit then
                State.LastReleasedTarget, State.LastReleasedAt = State.PrimaryTarget, os.clock()
                State.PrimaryTarget, State.PrimaryAttackCount = nil, 0
            end
        elseif not ok then
            State.PrimaryAvailable = false
            State.PrimaryTarget = nil
            Farm.AddLog("좌클릭 공격 오류 · F는 계속: " .. tostring(fired))
        end
    end
    if State.FAutoEnabled and State.SecondaryAvailable
    and State.FTarget and Target.IsAlive(State.FTarget) then
        local ok, fired = pcall(Weapon.UseF, State.FTarget)
        if ok and fired then
            State.FAttackCount += 1
            if Config.FAttackLimit > 0 and State.FAttackCount >= Config.FAttackLimit then
                State.LastReleasedTarget, State.LastReleasedAt = State.FTarget, os.clock()
                State.FTarget, State.FAttackCount = nil, 0
                Weapon.ClearImmediateLock()
            end
        elseif not ok then
            State.FAutoEnabled = false
            State.FTarget = nil
            Farm.AddLog("F 공격 오류 · 좌클릭은 계속: " .. tostring(fired))
            Weapon.ReleaseF()
            Weapon.ClearImmediateLock()
            Weapon.ClearFInput()
            Farm.RefreshFButton()
        end
    end
end))

Gui.Destroying:Connect(function()
    Farm.Stop()
    Route.Stop()
    for _, connection in ipairs(State.Connections) do
        connection:Disconnect()
    end
    for _, connection in ipairs(Target.Connections) do
        connection:Disconnect()
    end
    table.clear(State.Connections)
    table.clear(Target.Connections)
    table.clear(Target.Candidates)
    table.clear(Target.HealthSources)
end)


StartIntegratedAttack = function(isAutomatic)
    if type(SetVehicleWatchdogEnabled) == "function" then
        SetVehicleWatchdogEnabled(true)
    end
    local started = Farm.Start()
    if started then
        Work.Start(not isAutomatic)
    end
    return started
end
StopIntegratedAttack = Farm.Stop
UpdateSelectedVehicleCard = function(data)
    if not data then return end
    State.RecoveryFarmData = data
    if UI.VehicleImage then UI.VehicleImage.Image = data.Image or "" end
    if UI.VehicleName then UI.VehicleName.Text = data.Name or "이름 없음" end
    if UI.VehicleInfo then
        UI.VehicleInfo.RichText = true
        UI.VehicleInfo.Text = string.format("레벨 %s · %s", tostring(data.Level or 0), starText(data.Stars))
    end
end

UpdateRespawnCount = function(count)
    if UI.RespawnCount then
        UI.RespawnCount.Text = "재소환 " .. tostring(count or 0) .. "회"
    end
end

SetAttackPanelVisible = function(visible)
    if Main and Main.Parent then
        Main.Visible = visible
    end
end
CloseIntegratedAttack = function()
    Farm.Stop("통합 차량 소환창을 닫았습니다.")
    if Main and Main.Parent then
        Main:Destroy()
    end
    if Gui and Gui.Parent then
        Gui:Destroy()
    end
end

-- 쇼타임 통합 자동팜 연결부
do
    local Bridge = getgenv and getgenv().ShowTimeIntegratedBridge
    if Bridge then
        Bridge.FarmLoaded = true
        Bridge.FarmVersion = 35
        Bridge.OpenFarmWindow = function()
            if Gui and Gui.Parent then
                Gui.Enabled = true
                Root.Visible = true
                Main.Visible = true
            end
            if not State.Loading and not State.InventoryBootstrapRunning then
                task.spawn(function()
                    loadOwnedVehiclesForPopup(false)
                end)
            end
        end
        Bridge.HideFarmWindow = function()
            if Gui and Gui.Parent then
                Gui.Enabled = false
            end
            if Root and Root.Parent then
                Root.Visible = false
            end
        end
        Bridge.IsFarmWindowVisible = function()
            return Gui and Gui.Parent and Gui.Enabled
                and Root and Root.Parent and Root.Visible
        end
        Bridge.IsFarmRunning = function()
            return State.Running == true
        end
        Bridge.IsFarmSessionActive = function()
            return State.KeepRunning == true
        end
        Bridge.GetFarmSnapshot = function()
            local data = State.ActiveFarmData or State.Selected
            local pending = {}
            if Queue and type(Queue.Entries) == "table" then
                for index, entry in ipairs(Queue.Entries) do
                    table.insert(pending, {
                        Name = tostring(entry.Name or "이름 없음"),
                        InitialLevel = tonumber(entry.InitialLevel) or 0,
                        TargetLevel = tonumber(entry.TargetLevel) or 100,
                        UUID = entry.UUID,
                        AttackSettings = entry.AttackSettings,
                    })
                end
            end
            return {
                Running = State.Running == true,
                SessionActive = State.KeepRunning == true,
                VehicleName = data and data.Name or "",
                VehicleUUID = data and data.UUID or "",
                InitialLevel = tonumber(State.FarmInitialLevel) or (data and tonumber(data.Level)) or 0,
                Level = data and tonumber(data.Level) or 0,
                GoalLevel = tonumber(State.GoalLevel) or 100,
                QueueCount = Queue and #Queue.Entries or 0,
                QueueEntries = pending,
                AttackType = Config.GuidedPrimaryFamily and "슈레저형 유도탄" or "일반 기관총",
                GuidedPrimaryFamily = Config.GuidedPrimaryFamily == true,
                AttackSettings = CaptureAttackSettings(),
                PrimaryEnabled = State.PrimaryEnabled == true,
                FAutoEnabled = State.FAutoEnabled == true,
                WorkSeconds = Work and Work.GetElapsed and Work.GetElapsed() or 0,
                StatusText = UI.Status and UI.Status.Text or (State.Running and "자동공격 작동 중" or "대기"),
            }
        end
        Bridge.RestoreFarmRecovery = function(saved)
            if type(saved) ~= "table" or not isUUID(saved.VehicleUUID) then return false, "복구 차량 UUID가 없습니다" end
            task.spawn(function()
                loadOwnedVehiclesForPopup(false)
                local deadline, data = os.clock() + 20, nil
                repeat
                    data = Queue.FindData({UUID = saved.VehicleUUID})
                    if data then break end
                    task.wait(0.25)
                until os.clock() >= deadline
                if not data then
                    if Status then Status.Text = "복구 차량을 찾지 못했습니다 · 차량 자료 준비 후 다시 시도하세요" end
                    return
                end
                Queue.Entries = type(saved.QueueEntries) == "table" and saved.QueueEntries or {}
                Queue.SessionActive, Queue.SessionStartedUnix = #Queue.Entries > 0, tonumber(saved.SessionStartedUnix) or os.time()
                Queue.Completed, Queue.CurrentTransition = {}, nil
                if not ApplyAttackSettings(saved.AttackSettings) then
                    Config.GuidedPrimaryFamily = saved.GuidedPrimaryFamily == true
                end
                State.PrimaryEnabled, State.FAutoEnabled = saved.PrimaryEnabled ~= false, saved.FAutoEnabled ~= false
                State.Selected, State.ActiveFarmData = data, data
                State.FarmInitialLevel = tonumber(saved.InitialLevel) or tonumber(data.Level) or 0
                selectVehicle(data)
                ApplyVehicleGoalLevel(tonumber(saved.GoalLevel) or 100)
                Queue.Save()
                Queue.Render()
                if type(Farm.RefreshPrimaryButton) == "function" then Farm.RefreshPrimaryButton() end
                if type(Farm.RefreshFButton) == "function" then Farm.RefreshFButton() end
                spawnSelectedVehicle(false)
                Main.Visible = false
                if type(SetAttackPanelVisible) == "function" then SetAttackPanelVisible(true) end
                task.spawn(function()
					-- 복구 파일의 최초 시작 레벨이 아니라 재접속 시점의 실제 차량 레벨을 보냅니다.
					-- 차량 자료 연결이 늦는 계정을 위해 잠시 재확인하며, 레벨은 감소시키지 않습니다.
					local ResumeLevel = tonumber(data.Level) or tonumber(saved.Level) or tonumber(saved.InitialLevel) or 0
					local LevelDeadline = os.clock() + 5
					repeat
						if type(GetSelectedVehicleSnapshot) == "function" then
							local Snapshot = GetSelectedVehicleSnapshot()
							local DetectedLevel = Snapshot and tonumber(Snapshot.Level)
							if DetectedLevel and DetectedLevel > ResumeLevel then
								ResumeLevel = DetectedLevel
							end
						end
						if os.clock() < LevelDeadline then task.wait(0.25) end
					until os.clock() >= LevelDeadline
                    Discord.Send("⚠️ **서버 종료 감지 · 작업 복구 시작**\n\n계정: " .. Player.Name
                        .. "\n차량: " .. tostring(data.Name) .. "\n시작 레벨: " .. tostring(ResumeLevel)
                        .. "\n목표 레벨: " .. tostring(State.GoalLevel) .. "\n남은 대기열: " .. tostring(#Queue.Entries) .. "대")
                end)
            end)
            return true
        end
        Bridge.SaveRecoveryNow = function()
            if type(SaveFarmRecoveryDirect) ~= "function" then
                Bridge.RecoveryWriteVerified = false
                Bridge.RecoveryWriteError = "직접 저장 함수 준비 안 됨"
                return false, Bridge.RecoveryWriteError
            end
            local ok = SaveFarmRecoveryDirect("사용자 직접 저장")
            return ok, ok and "저장 확인 완료" or tostring(Bridge.RecoveryWriteError or "원인 미확인")
        end
        Bridge.StopFarmNow = function(reason)
            if type(SetVehicleWatchdogEnabled) == "function" then
                SetVehicleWatchdogEnabled(false)
            end
            Farm.Stop(reason or "사용자가 정지했습니다.")
        end
        Bridge.PauseFarmForSpin = function()
            if not State.Running then return false end
            Bridge.SpinPauseActive = true
            Farm.Stop("무료 스핀 처리로 일시정지")
            return true
        end
        Bridge.ResumeFarmAfterSpin = function()
            if not Bridge.SpinPauseActive then return false end
            Bridge.SpinPauseActive = false
            return StartIntegratedAttack(true)
        end
        Gui.Enabled = false
        Root.Visible = false
        if type(Bridge.OnFarmLoaded) == "function" then
            Bridge.OnFarmLoaded()
        end
    end
end

-- 모바일 전용 반응형 래퍼입니다. 자동팜·차량·공격 로직은 건드리지 않고
-- 기존 580 x 500 작업 좌표계를 화면의 안전 영역 안에서 확대/축소합니다.
local MobileUI = {
    Enabled = UserInputService.TouchEnabled,
    DesignWidth = 580,
    DesignHeight = 500,
    Drags = {},
    UserMovedRoot = false,
    FarmMinimized = false,
}

if MobileUI.Enabled then
    Gui.IgnoreGuiInset = false
    MobileUI.Scale = Instance.new("UIScale")
    MobileUI.Scale.Parent = Root
    MobileUI.DetailScale = Instance.new("UIScale")
    MobileUI.DetailScale.Parent = AttackDetail

    MobileUI.ClampWindow = function(Window)
        if not Window or not Window.Parent then return end
        local camera = Workspace.CurrentCamera
        local viewport = camera and camera.ViewportSize or Vector2.new(1440, 3040)
        local parentPosition = Window.Parent:IsA("GuiObject") and Window.Parent.AbsolutePosition or Vector2.new(0, 0)
        local position = Window.AbsolutePosition
        local size = Window.AbsoluteSize
        local margin = 10
        local x = math.clamp(position.X, margin, math.max(margin, viewport.X - size.X - margin))
        local y = math.clamp(position.Y, margin, math.max(margin, viewport.Y - size.Y - margin))
        Window.Position = UDim2.fromOffset(x - parentPosition.X, y - parentPosition.Y)
    end

    MobileUI.BindTitleDrag = function(Window, Handle, OnMoved)
        if not Window or not Handle then return end
        Handle.Active = true
        local Drag = {Active = false, Input = nil, StartPointer = nil, StartWindow = nil}
        table.insert(MobileUI.Drags, Drag)

        Handle.InputBegan:Connect(function(Input)
            if Input.UserInputType ~= Enum.UserInputType.Touch
            and Input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
            Drag.Active = true
            Drag.Input = Input
            Drag.StartPointer = Vector2.new(Input.Position.X, Input.Position.Y)
            Drag.StartWindow = Window.AbsolutePosition
        end)
        UserInputService.InputChanged:Connect(function(Input)
            if not Drag.Active or Input ~= Drag.Input then return end
            local pointer = Vector2.new(Input.Position.X, Input.Position.Y)
            local delta = pointer - Drag.StartPointer
            local camera = Workspace.CurrentCamera
            local viewport = camera and camera.ViewportSize or Vector2.new(1440, 3040)
            local size = Window.AbsoluteSize
            local margin = 10
            local target = Drag.StartWindow + delta
            local x = math.clamp(target.X, margin, math.max(margin, viewport.X - size.X - margin))
            local y = math.clamp(target.Y, margin, math.max(margin, viewport.Y - size.Y - margin))
            local parentPosition = Window.Parent:IsA("GuiObject") and Window.Parent.AbsolutePosition or Vector2.new(0, 0)
            Window.Position = UDim2.fromOffset(x - parentPosition.X, y - parentPosition.Y)
            if OnMoved then OnMoved() end
        end)
        UserInputService.InputEnded:Connect(function(Input)
            if Input == Drag.Input then
                Drag.Active = false
                Drag.Input = nil
                MobileUI.ClampWindow(Window)
            end
        end)
    end

    -- 기존 X는 모바일에서 기능을 멈추지 않는 명확한 뒤로가기 버튼으로 표시합니다.
    MobileUI.BackButton = Close
    MobileUI.BackButton.Text = "←"
    MobileUI.BackButton.Size = UDim2.fromOffset(44, 40)
    MobileUI.BackButton.Position = UDim2.new(1, -52, 0, 6)
    MobileUI.BackButton.TextSize = 22

    MobileUI.FarmMinimizeButton = Instance.new("TextButton")
    MobileUI.FarmMinimizeButton.Size = UDim2.fromOffset(44, 40)
    MobileUI.FarmMinimizeButton.Position = UDim2.new(1, -100, 0, 6)
    MobileUI.FarmMinimizeButton.BackgroundColor3 = Color3.fromRGB(55, 62, 78)
    MobileUI.FarmMinimizeButton.BorderSizePixel = 0
    MobileUI.FarmMinimizeButton.Text = "─"
    MobileUI.FarmMinimizeButton.TextColor3 = Color3.new(1, 1, 1)
    MobileUI.FarmMinimizeButton.TextSize = 20
    MobileUI.FarmMinimizeButton.Font = Enum.Font.GothamBold
    MobileUI.FarmMinimizeButton.Parent = Main
    MobileUI.FarmMinimizeCorner = Instance.new("UICorner")
    MobileUI.FarmMinimizeCorner.CornerRadius = UDim.new(0, 6)
    MobileUI.FarmMinimizeCorner.Parent = MobileUI.FarmMinimizeButton

    Title.Size = UDim2.new(1, -165, 0, 40)
    MobileUI.FarmMiniVehicle = Instance.new("TextLabel")
    MobileUI.FarmMiniVehicle.Size = UDim2.new(0.5, -18, 0, 42)
    MobileUI.FarmMiniVehicle.Position = UDim2.fromOffset(12, 58)
    MobileUI.FarmMiniVehicle.BackgroundTransparency = 1
    MobileUI.FarmMiniVehicle.TextColor3 = Color3.fromRGB(240, 240, 245)
    MobileUI.FarmMiniVehicle.TextSize = 15
    MobileUI.FarmMiniVehicle.Font = Enum.Font.GothamBold
    MobileUI.FarmMiniVehicle.TextXAlignment = Enum.TextXAlignment.Left
    MobileUI.FarmMiniVehicle.Visible = false
    MobileUI.FarmMiniVehicle.Parent = Main
    MobileUI.FarmMiniStatus = MobileUI.FarmMiniVehicle:Clone()
    MobileUI.FarmMiniStatus.Position = UDim2.new(0.5, 6, 0, 58)
    MobileUI.FarmMiniStatus.TextXAlignment = Enum.TextXAlignment.Right
    MobileUI.FarmMiniStatus.Parent = Main

    MobileUI.SetFarmMinimized = function(Minimized)
        MobileUI.FarmMinimized = Minimized == true
        if MobileUI.FarmMinimized then
            MobileUI.LastTab = AttackPanel.Visible and "Attack" or SettingsPanel.Visible and "Settings" or "Other"
            TabBar.Visible = false
            AttackPanel.Visible = false
            SettingsPanel.Visible = false
            OtherPanel.Visible = false
            Main.Size = UDim2.fromOffset(580, 124)
            MobileUI.FarmMiniVehicle.Visible = true
            MobileUI.FarmMiniStatus.Visible = true
            MobileUI.FarmMinimizeButton.Text = "□"
        else
            MobileUI.FarmMiniVehicle.Visible = false
            MobileUI.FarmMiniStatus.Visible = false
            MobileUI.FarmMinimizeButton.Text = "─"
            TabBar.Visible = true
            ShowTab(MobileUI.LastTab or "Attack")
        end
        MobileUI.ClampWindow(Root)
    end
    MobileUI.FarmMinimizeButton.MouseButton1Click:Connect(function()
        MobileUI.SetFarmMinimized(not MobileUI.FarmMinimized)
    end)

    MobileUI.ApplyViewport = function()
        local camera = Workspace.CurrentCamera
        local viewport = camera and camera.ViewportSize or Vector2.new(1440, 3040)
        local landscape = viewport.X > viewport.Y
        local widthRatio = (viewport.X * 0.92) / MobileUI.DesignWidth
        local heightRatio = (viewport.Y * (landscape and 0.76 or 0.82)) / MobileUI.DesignHeight
        local scale = math.clamp(math.min(widthRatio, heightRatio), 0.62, 3.2)

        MobileUI.Scale.Scale = scale
        Root.Size = UDim2.fromOffset(MobileUI.DesignWidth, MobileUI.DesignHeight)
        if not MobileUI.UserMovedRoot then
            Root.Position = UDim2.new(0.5, -(MobileUI.DesignWidth * scale * 0.5), 0.5, -(MobileUI.DesignHeight * scale * 0.5))
        end
        Root.Draggable = false

        -- 팝업 닫기는 손가락으로 누르기 쉬운 최소 44 논리 픽셀을 확보합니다.
        if Close then
            Close.Size = UDim2.fromOffset(44, 40)
            Close.Position = UDim2.new(1, -52, 0, 6)
            Close.TextSize = 18
        end
        if DetailClose then
            DetailClose.Size = UDim2.fromOffset(44, 40)
            DetailClose.Position = UDim2.new(1, -52, 0, 7)
            DetailClose.TextSize = 18
        end

        AttackDetail.Size = UDim2.fromOffset(450, 420)
        MobileUI.DetailScale.Scale = math.clamp(math.min((viewport.X * 0.92) / 450, (viewport.Y * 0.82) / 420), 0.7, 3.2)
        if not MobileUI.UserMovedDetail then
            AttackDetail.Position = UDim2.new(0.5, -(225 * MobileUI.DetailScale.Scale), 0.5, -(210 * MobileUI.DetailScale.Scale))
        end
        task.defer(function()
            MobileUI.ClampWindow(Root)
            MobileUI.ClampWindow(AttackDetail)
        end)
    end

    MobileUI.BindCamera = function(camera)
        if MobileUI.ViewportConnection then MobileUI.ViewportConnection:Disconnect() end
        if camera then
            MobileUI.ViewportConnection = camera:GetPropertyChangedSignal("ViewportSize"):Connect(MobileUI.ApplyViewport)
        end
        MobileUI.ApplyViewport()
    end

    MobileUI.CameraConnection = Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        MobileUI.BindCamera(Workspace.CurrentCamera)
    end)
    MobileUI.BindVehicleTitle = function()
        for _, Descendant in ipairs(Root:GetDescendants()) do
            if Descendant:IsA("TextLabel") and Descendant.Text == "보유차량 선택·소환" then
                MobileUI.BindTitleDrag(Root, Descendant, function() MobileUI.UserMovedRoot = true end)
                return
            end
        end
    end
    MobileUI.BindTitleDrag(Root, Title, function() MobileUI.UserMovedRoot = true end)
    MobileUI.BindTitleDrag(AttackDetail, DetailTitle, function() MobileUI.UserMovedDetail = true end)
    MobileUI.BindVehicleTitle()
    MobileUI.BindCamera(Workspace.CurrentCamera)

    task.spawn(function()
        while Gui and Gui.Parent do
            local Selected = State.ActiveFarmData or State.Selected
            MobileUI.FarmMiniVehicle.Text = "차량  " .. tostring(Selected and Selected.Name or "선택 없음")
            MobileUI.FarmMiniStatus.Text = State.Running and "● 자동팜 실행 중" or "○ 자동팜 대기"
            MobileUI.FarmMiniStatus.TextColor3 = State.Running
                and Color3.fromRGB(80, 220, 110) or Color3.fromRGB(190, 190, 200)
            task.wait(0.5)
        end
    end)
end

]====]

IntegratedBridge.FarmLoaded = false
IntegratedBridge.SpinPauseActive = false
IntegratedBridge.ReturnPending = false
IntegratedBridge.ReturnGeneration = 0

local function IntegratedFormatDuration(Seconds)
	Seconds = math.max(0, math.floor(tonumber(Seconds) or 0))
	local Hours = math.floor(Seconds / 3600)
	local Minutes = math.floor((Seconds % 3600) / 60)
	local RemainingSeconds = Seconds % 60
	return tostring(Hours) .. "시간 " .. tostring(Minutes) .. "분 " .. tostring(RemainingSeconds) .. "초"
end

local function IntegratedGoalLevelText(Value)
	return tonumber(Value) == 0
		and "무제한"
		or tostring(math.floor(tonumber(Value) or 100))
end

local function IntegratedServerText()
	if ServerDisplayState == "클랜서버" then
		return "클랜 서버", Color3.fromRGB(80, 220, 110)
	end
	return "일반 서버", Color3.fromRGB(255, 85, 85)
end

UI.Title.Text = "쇼타임 모바일 V3.9 조작성 시험본"
UI.CompactStatus.Visible = false
UI.CompactCombinedButton.Visible = false
UI.CompactQuickButton.Visible = false
UI.CompactExpandButton.Visible = false
UI.CompactServer.Visible = false
UI.CompactAccount.Visible = false

UI.Compact.Size = UDim2.fromOffset(420, 268)
UI.Compact.Position = UDim2.fromOffset(6, 33)

UI.IntegratedAccount = MakeLabel(UI.Compact, Player.Name, 10, 7, 240, 21, 13, true)
UI.IntegratedAccount.RichText = true
UI.IntegratedRecovery = MakeLabel(UI.Compact, "((복구기록: 확인 전))", 245, 7, 165, 21, 11, false)
UI.IntegratedRecovery.RichText = true
UI.IntegratedRecovery.TextXAlignment = Enum.TextXAlignment.Right
UI.IntegratedRecoverySave = MakeButton(UI.Compact, "복구 직접저장", 296, 31, 114, 24)
UI.IntegratedRecoverySave.TextSize = 11
UI.IntegratedRecoverySave.BackgroundColor3 = Color3.fromRGB(62, 82, 118)
-- 최소 UI 안쪽의 중복 확대·닫기 버튼은 제거했습니다.
-- 확대와 닫기는 상단 FPS 오른쪽의 기존 버튼만 사용합니다.
UI.IntegratedServer = MakeLabel(UI.Compact, "", 0, 0, 1, 1, 12, true)
UI.IntegratedServer.Visible = false
UI.IntegratedExpand = MakeButton(UI.Compact, "", 0, 0, 1, 1)
UI.IntegratedExpand.Visible = false
UI.IntegratedClose = MakeButton(UI.Compact, "", 0, 0, 1, 1)
UI.IntegratedClose.Visible = false

UI.IntegratedLine1 = MakeLabel(UI.Compact, "", 10, 36, 278, 22, 12, true)
UI.IntegratedLine1.RichText = true
UI.IntegratedLine2 = MakeLabel(UI.Compact, "", 10, 60, 400, 22, 12, true)
UI.IntegratedLine2.RichText = true
UI.IntegratedLine3 = MakeLabel(UI.Compact, "", 10, 84, 410, 22, 12, true)
UI.IntegratedLine3.RichText = true
UI.IntegratedLine3.Visible = false

local IntegratedCompactTab = "Current"
UI.IntegratedCurrentTab = MakeButton(UI.Compact, "현재 작업", 10, 86, 197, 26)
UI.IntegratedQueueTab = MakeButton(UI.Compact, "차량 대기열 0", 213, 86, 197, 26)
UI.IntegratedCurrentTab.TextSize = 12
UI.IntegratedQueueTab.TextSize = 12

UI.IntegratedDetail1 = MakeLabel(UI.Compact, "자동팜 대기 중", 12, 116, 396, 18, 12, true)
UI.IntegratedDetail2 = MakeLabel(UI.Compact, "팜을 시작하면 차량과 시작 레벨을 표시합니다", 12, 137, 396, 18, 11, false)
UI.IntegratedDetail3 = MakeLabel(UI.Compact, "", 12, 158, 396, 18, 11, false)
UI.IntegratedDetail4 = MakeLabel(UI.Compact, "", 12, 179, 396, 18, 11, false)
for _, Label in ipairs({UI.IntegratedDetail1, UI.IntegratedDetail2, UI.IntegratedDetail3, UI.IntegratedDetail4}) do
	Label.TextTruncate = Enum.TextTruncate.AtEnd
end

local function SetIntegratedCompactTab(TabName)
	IntegratedCompactTab = TabName == "Queue" and "Queue" or "Current"
	UI.IntegratedCurrentTab.BackgroundColor3 = IntegratedCompactTab == "Current"
		and Color3.fromRGB(62, 82, 118) or Color3.fromRGB(46, 46, 53)
	UI.IntegratedQueueTab.BackgroundColor3 = IntegratedCompactTab == "Queue"
		and Color3.fromRGB(62, 82, 118) or Color3.fromRGB(46, 46, 53)
end

AddConnection(UI.IntegratedCurrentTab.MouseButton1Click:Connect(function()
	SetIntegratedCompactTab("Current")
end))
AddConnection(UI.IntegratedQueueTab.MouseButton1Click:Connect(function()
	SetIntegratedCompactTab("Queue")
end))
SetIntegratedCompactTab("Current")

UI.IntegratedQuickButton = MakeButton(UI.Compact, "빠른 작업", 10, 198, 400, 28)
UI.IntegratedQuickButton.BackgroundColor3 = Color3.fromRGB(65, 80, 105)
UI.IntegratedMainButton = MakeButton(UI.Compact, "3D + UI 끄기", 10, 233, 195, 28)
UI.IntegratedFarmButton = MakeButton(UI.Compact, "자동팜 열기", 215, 233, 195, 28)
UI.IntegratedFarmButton.BackgroundColor3 = Color3.fromRGB(62, 82, 118)

UI.IntegratedConfirm = Instance.new("Frame")
UI.IntegratedConfirm.Size = UDim2.fromOffset(390, 170)
UI.IntegratedConfirm.Position = UDim2.new(0.5, -195, 0.5, -85)
UI.IntegratedConfirm.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
UI.IntegratedConfirm.BorderSizePixel = 0
UI.IntegratedConfirm.Visible = false
UI.IntegratedConfirm.ZIndex = 100
UI.IntegratedConfirm.Parent = UI.Gui
AddCorner(UI.IntegratedConfirm, 8)

UI.IntegratedConfirmTitle = MakeLabel(UI.IntegratedConfirm, "무엇을 정지하시겠습니까?", 14, 12, 360, 25, 15, true)
UI.IntegratedConfirmTitle.ZIndex = 101
UI.IntegratedConfirmGuide = MakeLabel(UI.IntegratedConfirm, "자동팜만 정지하면 차량에서 내린 뒤\n5초 후 AFK 위치로 자동 복귀합니다.", 14, 45, 360, 48, 12, false)
UI.IntegratedConfirmGuide.ZIndex = 101
UI.IntegratedCancel = MakeButton(UI.IntegratedConfirm, "취소", 14, 118, 105, 34)
UI.IntegratedFarmStop = MakeButton(UI.IntegratedConfirm, "자동팜만 정지", 128, 118, 120, 34)
UI.IntegratedAllStop = MakeButton(UI.IntegratedConfirm, "통합 기능 전체정지", 257, 118, 119, 34)
UI.IntegratedAllStop.BackgroundColor3 = Color3.fromRGB(145, 55, 55)
for _, Object in ipairs({UI.IntegratedCancel, UI.IntegratedFarmStop, UI.IntegratedAllStop}) do
	Object.ZIndex = 101
end

UI.IntegratedQuickPopup = Instance.new("Frame")
UI.IntegratedQuickPopup.Size = UDim2.fromOffset(390, 300)
UI.IntegratedQuickPopup.Position = UDim2.new(0.5, -195, 0.5, -150)
UI.IntegratedQuickPopup.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
UI.IntegratedQuickPopup.BorderSizePixel = 0
UI.IntegratedQuickPopup.Visible = false
UI.IntegratedQuickPopup.ZIndex = 80
UI.IntegratedQuickPopup.Parent = UI.Gui
AddCorner(UI.IntegratedQuickPopup, 8)

UI.IntegratedQuickTitle = MakeLabel(UI.IntegratedQuickPopup, "빠른 작업", 14, 10, 320, 25, 15, true)
UI.IntegratedQuickTitle.ZIndex = 81
UI.IntegratedQuickClose = MakeButton(UI.IntegratedQuickPopup, "X", 348, 7, 28, 26)
UI.IntegratedQuickClose.ZIndex = 81

local function MakeIntegratedQuickButton(Text, X, Y, W)
	local Button = MakeButton(UI.IntegratedQuickPopup, Text, X, Y, W or 176, 34)
	Button.ZIndex = 81
	Button.TextSize = 12
	return Button
end

UI.QuickCaptureStart = MakeIntegratedQuickButton("점령 자동 시작", 14, 45)
UI.QuickCaptureStop = MakeIntegratedQuickButton("점령 즉시 정지", 200, 45)
UI.QuickPoint1New = MakeIntegratedQuickButton("점령지 1 이동", 14, 85)
UI.QuickPoint2New = MakeIntegratedQuickButton("점령지 2 이동", 200, 85)
UI.QuickBaseNew = MakeIntegratedQuickButton("기지로 복귀", 14, 125)
UI.QuickAFKNew = MakeIntegratedQuickButton("AFK 위치로 복귀", 200, 125)
UI.QuickSpinNew = MakeIntegratedQuickButton("스핀 즉시 확인", 14, 165)
UI.QuickServerAction = MakeIntegratedQuickButton("서버 작업", 200, 165)
UI.QuickAutoUIOff = MakeIntegratedQuickButton("1분 UI 자동끄기: 켜짐", 14, 205)
UI.QuickAutoUIOff.BackgroundColor3 = Color3.fromRGB(50, 125, 80)
UI.QuickAFKCancelRespawn = MakeIntegratedQuickButton("AFK 취소·리스폰", 200, 205)
UI.QuickAFKCancelRespawn.BackgroundColor3 = Color3.fromRGB(145, 70, 55)

UI.IntegratedFullFarmButton = MakeButton(UI.WorkPage, "차량 자동팜 열기", 7, 110, 314, 27)
UI.IntegratedFullFarmButton.BackgroundColor3 = Color3.fromRGB(62, 82, 118)

-- V1.1 확대 화면은 기존 확대 영역과 겹치지 않는 단일 탭 화면으로 구성합니다.
UI.V11Expanded = Instance.new("Frame")
UI.V11Expanded.Size = UDim2.fromOffset(430, 260)
UI.V11Expanded.Position = UDim2.fromOffset(6, 33)
UI.V11Expanded.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
UI.V11Expanded.BorderSizePixel = 0
UI.V11Expanded.Visible = false
UI.V11Expanded.Parent = UI.Main
AddCorner(UI.V11Expanded, 6)

UI.V11Tabs = Instance.new("Frame")
UI.V11Tabs.Size = UDim2.fromOffset(418, 30)
UI.V11Tabs.Position = UDim2.fromOffset(6, 6)
UI.V11Tabs.BackgroundColor3 = Color3.fromRGB(31, 31, 38)
UI.V11Tabs.BorderSizePixel = 0
UI.V11Tabs.Parent = UI.V11Expanded
AddCorner(UI.V11Tabs, 5)

UI.V11TabButtons = {}
UI.V11Pages = {}
for Index, Name in ipairs({"대시보드", "점령·AFK", "스핀", "설정·기록"}) do
    local Button = MakeButton(UI.V11Tabs, Name, 4 + ((Index - 1) * 103), 4, 100, 22)
    Button.TextSize = 11
    UI.V11TabButtons[Name] = Button

    local Page = Instance.new("Frame")
    Page.Name = Name
    Page.Size = UDim2.fromOffset(418, 212)
    Page.Position = UDim2.fromOffset(6, 42)
    Page.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
    Page.BorderSizePixel = 0
    Page.Visible = Name == "대시보드"
    Page.Parent = UI.V11Expanded
    AddCorner(Page, 5)
    UI.V11Pages[Name] = Page
end
UI.V11CurrentPage = "대시보드"

UI.V11AccountCard = MakeLabel(UI.V11Pages["대시보드"], "", 8, 8, 196, 70, 12, false)
UI.V11AccountCard.BackgroundTransparency = 0
UI.V11AccountCard.BackgroundColor3 = Color3.fromRGB(35, 35, 43)
AddCorner(UI.V11AccountCard, 5)
UI.V11StateCard = MakeLabel(UI.V11Pages["대시보드"], "", 214, 8, 196, 70, 12, false)
UI.V11StateCard.BackgroundTransparency = 0
UI.V11StateCard.BackgroundColor3 = Color3.fromRGB(35, 35, 43)
AddCorner(UI.V11StateCard, 5)
UI.V11DiamondCard = MakeLabel(UI.V11Pages["대시보드"], "", 8, 86, 196, 70, 12, false)
UI.V11DiamondCard.BackgroundTransparency = 0
UI.V11DiamondCard.BackgroundColor3 = Color3.fromRGB(35, 35, 43)
UI.V11DiamondCard.TextColor3 = Color3.fromRGB(190, 110, 255)
AddCorner(UI.V11DiamondCard, 5)
UI.V11FarmCard = MakeLabel(UI.V11Pages["대시보드"], "", 214, 86, 196, 70, 12, false)
UI.V11FarmCard.BackgroundTransparency = 0
UI.V11FarmCard.BackgroundColor3 = Color3.fromRGB(35, 35, 43)
AddCorner(UI.V11FarmCard, 5)
UI.V11Quick = MakeButton(UI.V11Pages["대시보드"], "빠른 작업", 8, 166, 126, 36)
UI.V11Farm = MakeButton(UI.V11Pages["대시보드"], "자동팜 열기", 146, 166, 126, 36)
UI.V11Farm.BackgroundColor3 = Color3.fromRGB(62, 82, 118)
UI.V11StopAll = MakeButton(UI.V11Pages["대시보드"], "통합 기능 정지", 284, 166, 126, 36)
UI.V11StopAll.BackgroundColor3 = Color3.fromRGB(145, 55, 55)

UI.V11CaptureState = MakeLabel(UI.V11Pages["점령·AFK"], "", 8, 8, 402, 34, 12, true)
UI.V11CaptureStart = MakeButton(UI.V11Pages["점령·AFK"], "점령 자동 시작", 8, 50, 196, 32)
UI.V11CaptureStop = MakeButton(UI.V11Pages["점령·AFK"], "점령 즉시 정지", 214, 50, 196, 32)
UI.V11Point1 = MakeButton(UI.V11Pages["점령·AFK"], "점령지 1 이동", 8, 90, 196, 32)
UI.V11Point2 = MakeButton(UI.V11Pages["점령·AFK"], "점령지 2 이동", 214, 90, 196, 32)
UI.V11Base = MakeButton(UI.V11Pages["점령·AFK"], "기지로 복귀", 8, 130, 196, 32)
UI.V11AFK = MakeButton(UI.V11Pages["점령·AFK"], "AFK 위치로 복귀", 214, 130, 196, 32)
UI.V11AFKCancel = MakeButton(UI.V11Pages["점령·AFK"], "AFK 취소·리스폰", 8, 170, 402, 32)
UI.V11AFKCancel.BackgroundColor3 = Color3.fromRGB(145, 70, 55)

UI.V11SpinInfo = MakeLabel(UI.V11Pages["스핀"], "", 8, 8, 402, 82, 13, false)
UI.V11SpinInfo.BackgroundTransparency = 0
UI.V11SpinInfo.BackgroundColor3 = Color3.fromRGB(35, 35, 43)
AddCorner(UI.V11SpinInfo, 5)
UI.V11SpinNow = MakeButton(UI.V11Pages["스핀"], "스핀 즉시 확인", 8, 102, 196, 36)
UI.V11SpinToggle = MakeButton(UI.V11Pages["스핀"], "자동 스핀: 켜짐", 214, 102, 196, 36)
UI.V11SpinGuide = MakeLabel(UI.V11Pages["스핀"], "자동팜 작동 중에는 잠시 멈춘 뒤 스핀을 우선 처리하고 자동으로 복귀합니다.", 8, 150, 402, 44, 11, false)

UI.V11SettingsInfo = MakeLabel(UI.V11Pages["설정·기록"], "", 8, 8, 402, 74, 12, false)
UI.V11SettingsInfo.BackgroundTransparency = 0
UI.V11SettingsInfo.BackgroundColor3 = Color3.fromRGB(35, 35, 43)
AddCorner(UI.V11SettingsInfo, 5)
UI.V11FPS = MakeButton(UI.V11Pages["설정·기록"], "FPS 제한", 8, 94, 196, 34)
UI.V11AutoUI = MakeButton(UI.V11Pages["설정·기록"], "1분 UI 자동끄기", 214, 94, 196, 34)
UI.V11Errors = MakeButton(UI.V11Pages["설정·기록"], "최근 오류 기록", 8, 138, 196, 34)
UI.V11Records = MakeButton(UI.V11Pages["설정·기록"], "24시간 운용 기록", 214, 138, 196, 34)
UI.V11RecordGuide = MakeLabel(UI.V11Pages["설정·기록"], "오류·운용 기록의 상세 저장 기능은 24시간 시험 결과에 맞춰 다음 단계에서 연결합니다.", 8, 178, 402, 28, 10, false)

-- 전체 화면 탭 이름과 순서를 통합 구조에 맞게 정리합니다.
UI.WorkTab.Text = "메인"
UI.MoveTab.Text = "점령·이동"
UI.SpinTab.Text = "스핀·AFK"
UI.SettingsTab.Text = "설정"
UI.WorkTab.TextSize = 11
UI.MoveTab.TextSize = 11
UI.SpinTab.TextSize = 11
UI.SettingsTab.TextSize = 11
UI.SpinTab.Position = UDim2.fromOffset(165, 3)
UI.SettingsTab.Position = UDim2.fromOffset(246, 3)

local OriginalSetCompactMode = UI.SetCompactMode
UI.SetCompactMode = function(State)
	OriginalSetCompactMode(State)
	UI.MinimizeButton.Visible = true
	UI.MinimizeButton.Text = State and "□" or "─"
	UI.MinimizeButton.TextSize = State and 16 or 14
	UI.Left.Visible = false
	UI.Right.Visible = false
	UI.V11Expanded.Visible = not State
	if State then
		UI.Main.Size = UDim2.fromOffset(442, 308)
		UI.Main.Position = UDim2.new(0.5, -221, 0, 8)
	else
		UI.Main.Size = UDim2.fromOffset(442, 300)
		UI.Main.Position = UDim2.new(0.5, -221, 0, 8)
	end
end

local function LoadIntegratedFarm()
	SetGameUIVisible(true)
	if IntegratedBridge.FarmLoaded and IntegratedBridge.FarmVersion == 35 and IntegratedBridge.OpenFarmWindow then
		UI.Main.Visible = false
		IntegratedBridge.OpenFarmWindow()
		return true
	end
	IntegratedBridge.FarmLoaded = false
	if type(loadstring) ~= "function" then
		RuntimeState.StateText = "자동팜 불러오기 실패: loadstring 미지원"
		return false
	end
	local Loader, CompileError = loadstring(FARM_SOURCE)
	if not Loader then
		RuntimeState.StateText = "자동팜 문법 오류: " .. tostring(CompileError)
		return false
	end
	local Success, ErrorText = pcall(Loader)
	if not Success then
		RuntimeState.StateText = "자동팜 실행 오류: " .. tostring(ErrorText)
		return false
	end
	if IntegratedBridge.OpenFarmWindow then
		UI.Main.Visible = false
		IntegratedBridge.OpenFarmWindow()
	end
	return true
end

local function SaveCurrentFarmRecovery()
	if type(IntegratedBridge.GetFarmSnapshot) ~= "function" then return false end
	local Snapshot = IntegratedBridge.GetFarmSnapshot()
	if type(Snapshot) ~= "table" or Snapshot.VehicleUUID == "" then return false end
	Snapshot.SessionStartedUnix = RuntimeState.FarmRecovery and RuntimeState.FarmRecovery.SessionStartedUnix or os.time()
	return SaveFarmRecovery(Snapshot)
end

IntegratedBridge.OnRecoveryStateChanged = function()
	if RuntimeState.FarmRecoveryPending or (type(IntegratedBridge.IsFarmSessionActive) == "function" and IntegratedBridge.IsFarmSessionActive()) then
		SaveCurrentFarmRecovery()
	end
end

IntegratedBridge.OnFarmPrepared = function()
	local Saved = SaveCurrentFarmRecovery()
	if Saved then
		RuntimeState.StateText = "복구 파일 저장 확인 완료 · 자동팜 시작"
	else
		RuntimeState.StateText = "복구 파일 저장 실패 · 재접속 복구 불가"
	end
	return Saved
end

IntegratedBridge.OnFarmAllCompleted = function()
	ClearFarmRecovery()
	RuntimeState.StateText = "현재 차량과 대기열 정상 완료 · AFK 복귀 준비"
end

IntegratedBridge.ClearFarmRecovery = ClearFarmRecovery

RuntimeState.BeginFarmRecovery = function()
	local Saved = RuntimeState.FarmRecovery
	if not RuntimeState.FarmRecoveryPending or type(Saved) ~= "table" or not LoadIntegratedFarm() then return end
	task.spawn(function()
		local Deadline = os.clock() + 15
		repeat
			if type(IntegratedBridge.RestoreFarmRecovery) == "function" then
				local Ok, Reason = IntegratedBridge.RestoreFarmRecovery(Saved)
				RuntimeState.StateText = Ok and "서버 종료 감지 · 작업 복구 시작" or ("자동팜 복구 실패: " .. tostring(Reason))
				return
			end
			task.wait(0.25)
		until os.clock() >= Deadline
		RuntimeState.StateText = "자동팜 복구 기능 준비 시간 초과"
	end)
end

IntegratedBridge.OnFarmLoaded = function()
	RuntimeState.StateText = "자동팜 준비 완료"
end

IntegratedBridge.ReturnToMain = function()
	UI.Main.Visible = true
	UI.SetCompactMode(true)
end

RuntimeState.ShiftRestoreView = "main"
AddConnection(UserInputService.InputBegan:Connect(function(Input)
	if Input.KeyCode ~= Enum.KeyCode.RightShift then
		return
	end

	local FarmVisible = type(IntegratedBridge.IsFarmWindowVisible) == "function"
		and IntegratedBridge.IsFarmWindowVisible()
	local MainVisible = UI.Gui and UI.Gui.Enabled and UI.Main and UI.Main.Visible

	if FarmVisible or MainVisible then
		RuntimeState.ShiftRestoreView = FarmVisible and "farm" or "main"
		if UI.Main then UI.Main.Visible = false end
		if type(IntegratedBridge.HideFarmWindow) == "function" then
			IntegratedBridge.HideFarmWindow()
		end
		return
	end

	if RuntimeState.ShiftRestoreView == "farm"
	and type(IntegratedBridge.OpenFarmWindow) == "function" then
		UI.Main.Visible = false
		IntegratedBridge.OpenFarmWindow()
	else
		if type(IntegratedBridge.HideFarmWindow) == "function" then
			IntegratedBridge.HideFarmWindow()
		end
		UI.Gui.Enabled = true
		UI.Main.Visible = true
		UI.SetCompactMode(true)
	end
end))

IntegratedBridge.OnFarmStarted = function()
	IntegratedBridge.ReturnGeneration = (IntegratedBridge.ReturnGeneration or 0) + 1
	IntegratedBridge.ReturnPending = false
	ApplyFPSCap(15)
	SetFPSLimitEnabled(true)
	RuntimeState.StateText = "차량 자동팜 작동 중"
	local Saved = SaveCurrentFarmRecovery()
	RuntimeState.StateText = Saved
		and "차량 자동팜 작동 중 · 복구 저장 확인됨"
		or "차량 자동팜 작동 중 · 복구 저장 실패"
end

IntegratedBridge.OnFarmStopped = function(Reason)
	if IntegratedBridge.SpinPauseActive then
		return
	end
	if IntegratedBridge.ReturnPending then
		return
	end
	IntegratedBridge.ReturnPending = true
	IntegratedBridge.ReturnGeneration = (IntegratedBridge.ReturnGeneration or 0) + 1
	local ThisReturnGeneration = IntegratedBridge.ReturnGeneration
	RuntimeState.StateText = Reason or "자동팜 정지, AFK 복귀 준비"
	task.spawn(function()
		local Character = Player.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		if Humanoid then
			Humanoid.Sit = false
		end
		task.wait(5)
		if not Running or IntegratedBridge.SpinPauseActive
		or IntegratedBridge.ReturnGeneration ~= ThisReturnGeneration then
			IntegratedBridge.ReturnPending = false
			return
		end
		RuntimeState.StateText = "AFK 위치로 복귀 중"
		SetFPSLimitEnabled(false)
		local Started = MoveToAFK()
		if Started then
			ApplyFPSCap(15)
			SetFPSLimitEnabled(true)
			RuntimeState.StateText = "AFK 정상 작동"
		else
			RuntimeState.StateText = "AFK 복귀 실패"
		end
		IntegratedBridge.ReturnPending = false
	end)
end

local function ShowIntegratedStopConfirm(Mode)
	IntegratedBridge.ConfirmMode = Mode or "farm"
	UI.IntegratedConfirm.Visible = true

	local FarmMode = IntegratedBridge.ConfirmMode == "farm"
	UI.IntegratedFarmStop.Visible = FarmMode
	UI.IntegratedConfirmGuide.Text = FarmMode
		and "자동팜만 정지하면 차량에서 내린 뒤\n5초 후 AFK 위치로 자동 복귀합니다."
		or "점령·스핀·AFK·자동팜을 포함한\n통합 기능 전체를 정지합니다."

	if FarmMode then
		UI.IntegratedCancel.Position = UDim2.fromOffset(14, 118)
		UI.IntegratedCancel.Size = UDim2.fromOffset(105, 34)
		UI.IntegratedAllStop.Position = UDim2.fromOffset(257, 118)
		UI.IntegratedAllStop.Size = UDim2.fromOffset(119, 34)
	else
		UI.IntegratedCancel.Position = UDim2.fromOffset(14, 118)
		UI.IntegratedCancel.Size = UDim2.fromOffset(176, 34)
		UI.IntegratedAllStop.Position = UDim2.fromOffset(200, 118)
		UI.IntegratedAllStop.Size = UDim2.fromOffset(176, 34)
	end
end

IntegratedBridge.RequestAllStopConfirm = function()
	UI.Main.Visible = true
	UI.SetCompactMode(true)
	ShowIntegratedStopConfirm("all")
end

IntegratedBridge.RequestStopConfirm = function()
	if IntegratedBridge.HideFarmWindow then
		IntegratedBridge.HideFarmWindow()
	end
	UI.Main.Visible = true
	UI.SetCompactMode(true)
	ShowIntegratedStopConfirm("farm")
end

UI.ShowV11Page = function(Name)
	UI.V11CurrentPage = Name
	for PageName, Page in pairs(UI.V11Pages) do
		Page.Visible = PageName == Name
	end
	for ButtonName, Button in pairs(UI.V11TabButtons) do
		Button.BackgroundColor3 = ButtonName == Name
			and Color3.fromRGB(68, 68, 82)
			or Color3.fromRGB(48, 48, 57)
	end
end

for Name, Button in pairs(UI.V11TabButtons) do
	Button.MouseButton1Click:Connect(function()
		UI.ShowV11Page(Name)
	end)
end

UI.ToggleV11FPS = function()
	if FPS_ENABLED then
		SetFPSLimitEnabled(false)
		RuntimeState.StateText = "FPS 제한 꺼짐"
	else
		ApplyFPSCap(15)
		SetFPSLimitEnabled(true)
		RuntimeState.StateText = "FPS 15 제한 켜짐"
	end
end

UI.HeaderFPS.MouseButton1Click:Connect(UI.ToggleV11FPS)
UI.V11FPS.MouseButton1Click:Connect(UI.ToggleV11FPS)
UI.V11Quick.MouseButton1Click:Connect(function()
	UI.IntegratedQuickPopup.Visible = true
end)
UI.V11Farm.MouseButton1Click:Connect(function()
	-- 자동팜 작동 여부와 관계없이 현재 팜 메인 화면을 엽니다.
	LoadIntegratedFarm()
end)
UI.V11StopAll.MouseButton1Click:Connect(function()
	ShowIntegratedStopConfirm("all")
end)
UI.V11CaptureStart.MouseButton1Click:Connect(function()
	StartWork()
end)
UI.V11CaptureStop.MouseButton1Click:Connect(function()
	RuntimeState.Working = false
	RuntimeState.RemainingTime = 0
	StopCaptureMovement()
	RuntimeState.StateText = "점령 즉시 정지 완료"
end)
UI.V11Point1.MouseButton1Click:Connect(function()
	if RuntimeState.Working or RuntimeState.SpinBusy then return end
	StopCaptureMovement()
	RuntimeState.StateText = "점령지 1 이동 중"
	task.spawn(function()
		RuntimeState.StateText = FlyToCapturePoint(Settings.POINT_1, CAPTURE_MOVE_SPEED, false)
			and "점령지 1 도착" or "점령지 1 이동 실패"
	end)
end)
UI.V11Point2.MouseButton1Click:Connect(function()
	if RuntimeState.Working or RuntimeState.SpinBusy then return end
	StopCaptureMovement()
	RuntimeState.StateText = "점령지 2 이동 중"
	task.spawn(function()
		RuntimeState.StateText = FlyToCapturePoint(Settings.POINT_2, CAPTURE_MOVE_SPEED, false)
			and "점령지 2 도착" or "점령지 2 이동 실패"
	end)
end)
UI.V11Base.MouseButton1Click:Connect(function()
	if RuntimeState.Working or RuntimeState.SpinBusy or not RuntimeState.BaseSaved or not RuntimeState.BasePoint then
		RuntimeState.StateText = "기지 복귀 준비가 되지 않았습니다."
		return
	end
	RuntimeState.StateText = "기지로 복귀 중"
	Teleport(RuntimeState.BasePoint)
	RefreshDiamondsAfterReturn()
end)
UI.V11AFK.MouseButton1Click:Connect(function()
	if IntegratedBridge.IsFarmSessionActive and IntegratedBridge.IsFarmSessionActive() then
		ShowIntegratedStopConfirm("farm")
		return
	end
	if RuntimeState.Working or RuntimeState.SpinBusy then
		RuntimeState.StateText = "현재 작업을 먼저 정지하세요."
		return
	end
	task.spawn(function()
		RuntimeState.StateText = "AFK 위치로 복귀 중"
		SetFPSLimitEnabled(false)
		if MoveToAFK() then
			ApplyFPSCap(15)
			SetFPSLimitEnabled(true)
			RuntimeState.StateText = "AFK 정상 작동"
		else
			RuntimeState.StateText = "AFK 복귀 실패"
		end
	end)
end)
UI.V11AFKCancel.MouseButton1Click:Connect(function()
	RuntimeState.AFKEnabled = false
	RuntimeState.AFKInitialCollectDone = false
	RuntimeState.AFKNextCollectAt = nil
	RuntimeState.AFKNextIdleInputAt = nil
	RuntimeState.Working = false
	RuntimeState.RemainingTime = 0
	RuntimeState.BaseReturnGuardRunning = false
	StopCaptureMovement()
	SetFPSLimitEnabled(false)
	SetRendering(true)
	SetGameUIVisible(true)
	RuntimeState.StateText = "AFK 수동 취소, 캐릭터 리스폰 중"
	local Character = Player.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	if Humanoid then
		Humanoid.Sit = false
		Humanoid.Health = 0
	end
end)
UI.V11SpinNow.MouseButton1Click:Connect(function()
	if RuntimeState.SpinBusy or RuntimeState.Working then
		RuntimeState.StateText = "현재 작업 완료 후 스핀을 확인합니다."
		return
	end
	task.spawn(RunFreeSpin)
end)
UI.V11SpinToggle.MouseButton1Click:Connect(function()
	RuntimeState.AutoSpinEnabled = not RuntimeState.AutoSpinEnabled
	RuntimeState.StateText = RuntimeState.AutoSpinEnabled and "자동 스핀 켜짐" or "자동 스핀 꺼짐"
end)
UI.V11AutoUI.MouseButton1Click:Connect(function()
	RuntimeState.AutoGameUIOff60 = not RuntimeState.AutoGameUIOff60
	RuntimeState.StateText = RuntimeState.AutoGameUIOff60
		and "1분마다 게임 UI 자동 끄기 켜짐"
		or "1분마다 게임 UI 자동 끄기 꺼짐"
end)
UI.V11Errors.MouseButton1Click:Connect(function()
	RuntimeState.StateText = "최근 오류 기록은 24시간 시험 후 연결합니다."
end)
UI.V11Records.MouseButton1Click:Connect(function()
	RuntimeState.StateText = "24시간 운용 기록은 시험 결과에 맞춰 연결합니다."
end)

UI.ShowV11Page("대시보드")

UI.IntegratedExpand.MouseButton1Click:Connect(function()
	UI.SetCompactMode(false)
end)
UI.IntegratedClose.MouseButton1Click:Connect(function()
	ShowIntegratedStopConfirm("all")
end)
UI.IntegratedQuickButton.MouseButton1Click:Connect(function()
	UI.IntegratedQuickPopup.Visible = true
end)
UI.IntegratedQuickClose.MouseButton1Click:Connect(function()
	UI.IntegratedQuickPopup.Visible = false
end)
UI.IntegratedMainButton.MouseButton1Click:Connect(function()
	local BothOn = RuntimeState.RenderingEnabled and RuntimeState.GameUIVisible
	local TargetState = not BothOn
	SetRendering(TargetState)
	SetGameUIVisible(TargetState)
end)
UI.IntegratedFarmButton.MouseButton1Click:Connect(function()
	-- 축소 UI에서도 파밍을 정지하지 않고 팜 화면으로 이동합니다.
	LoadIntegratedFarm()
end)
UI.IntegratedFullFarmButton.MouseButton1Click:Connect(function()
	LoadIntegratedFarm()
end)
UI.IntegratedRecoverySave.MouseButton1Click:Connect(function()
	if type(IntegratedBridge.SaveRecoveryNow) ~= "function" then
		RuntimeState.FarmRecoveryStatus = "복구오류: 자동팜을 먼저 열어주세요"
		UI.IntegratedRecoverySave.Text = "직접저장 실패"
		UI.IntegratedRecoverySave.BackgroundColor3 = Color3.fromRGB(160, 55, 55)
		return
	end
	local Ok, Message = IntegratedBridge.SaveRecoveryNow()
	if Ok then
		RuntimeState.FarmRecoveryStatus = "복구기록: 저장 확인 완료"
		UI.IntegratedRecoverySave.Text = "직접저장 완료"
		UI.IntegratedRecoverySave.BackgroundColor3 = Color3.fromRGB(45, 145, 80)
	else
		RuntimeState.FarmRecoveryStatus = "복구오류: " .. tostring(Message or "원인 미확인")
		UI.IntegratedRecoverySave.Text = "직접저장 실패"
		UI.IntegratedRecoverySave.BackgroundColor3 = Color3.fromRGB(160, 55, 55)
	end
end)
UI.IntegratedCancel.MouseButton1Click:Connect(function()
	UI.IntegratedConfirm.Visible = false
end)
UI.IntegratedFarmStop.MouseButton1Click:Connect(function()
	UI.IntegratedConfirm.Visible = false
	ClearFarmRecovery()
	if IntegratedBridge.StopFarmNow then
		IntegratedBridge.StopFarmNow("사용자가 자동팜을 정지했습니다.")
	end
end)
UI.IntegratedAllStop.MouseButton1Click:Connect(function()
	UI.IntegratedConfirm.Visible = false
	ClearFarmRecovery()
	if IntegratedBridge.StopFarmNow then
		IntegratedBridge.StopFarmNow("통합 기능 전체정지")
	end
	Running = false
	RuntimeState.Working = false
	RuntimeState.AutoSpinEnabled = false
	AutoButtonRunning = false
	StopCaptureMovement()
	SetGameUIVisible(true)
	SetRendering(true)
	SetFPSLimitEnabled(false)
	if UI.Gui and UI.Gui.Parent then
		UI.Gui:Destroy()
	end
end)

UI.QuickCaptureStart.MouseButton1Click:Connect(function()
	UI.IntegratedQuickPopup.Visible = false
	StartWork()
end)
UI.QuickCaptureStop.MouseButton1Click:Connect(function()
	RuntimeState.Working = false
	RuntimeState.RemainingTime = 0
	StopCaptureMovement()
	RuntimeState.StateText = "점령 즉시 정지 완료"
end)
UI.QuickPoint1New.MouseButton1Click:Connect(function()
	UI.IntegratedQuickPopup.Visible = false
	if RuntimeState.Working or RuntimeState.SpinBusy then return end
	StopCaptureMovement()
	RuntimeState.StateText = "점령지 1 이동 중"
	task.spawn(function()
		RuntimeState.StateText = FlyToCapturePoint(Settings.POINT_1, CAPTURE_MOVE_SPEED, false)
			and "점령지 1 도착"
			or "점령지 1 이동 실패"
	end)
end)
UI.QuickPoint2New.MouseButton1Click:Connect(function()
	UI.IntegratedQuickPopup.Visible = false
	if RuntimeState.Working or RuntimeState.SpinBusy then return end
	StopCaptureMovement()
	RuntimeState.StateText = "점령지 2 이동 중"
	task.spawn(function()
		RuntimeState.StateText = FlyToCapturePoint(Settings.POINT_2, CAPTURE_MOVE_SPEED, false)
			and "점령지 2 도착"
			or "점령지 2 이동 실패"
	end)
end)
UI.QuickBaseNew.MouseButton1Click:Connect(function()
	UI.IntegratedQuickPopup.Visible = false
	if RuntimeState.Working or RuntimeState.SpinBusy or not RuntimeState.BaseSaved or not RuntimeState.BasePoint then
		RuntimeState.StateText = "기지 복귀 준비가 되지 않았습니다."
		return
	end
	RuntimeState.StateText = "기지로 복귀 중"
	Teleport(RuntimeState.BasePoint)
	RefreshDiamondsAfterReturn()
end)
UI.QuickAFKNew.MouseButton1Click:Connect(function()
	UI.IntegratedQuickPopup.Visible = false
	if IntegratedBridge.IsFarmSessionActive and IntegratedBridge.IsFarmSessionActive() then
		ShowIntegratedStopConfirm("farm")
		return
	end
	if RuntimeState.Working or RuntimeState.SpinBusy then
		RuntimeState.StateText = "현재 작업을 먼저 정지하세요."
		return
	end
	task.spawn(function()
		RuntimeState.StateText = "AFK 위치로 복귀 중"
		SetFPSLimitEnabled(false)
		if MoveToAFK() then
			ApplyFPSCap(15)
			SetFPSLimitEnabled(true)
			RuntimeState.StateText = "AFK 정상 작동"
		else
			RuntimeState.StateText = "AFK 복귀 실패"
		end
	end)
end)
UI.QuickSpinNew.MouseButton1Click:Connect(function()
	UI.IntegratedQuickPopup.Visible = false
	if RuntimeState.SpinBusy or RuntimeState.Working then
		RuntimeState.StateText = "현재 작업 완료 후 스핀을 확인합니다."
		return
	end
	task.spawn(RunFreeSpin)
end)
UI.QuickServerAction.MouseButton1Click:Connect(function()
	UI.IntegratedQuickPopup.Visible = false
	if ServerDisplayState == "클랜서버" then
		UpdateDiamonds()
		RuntimeState.StateText = "다이아 다시 확인 완료"
		return
	end
	RuntimeState.StateText = "클랜 서버 입장 재시도"
	task.spawn(function()
		local Modules = LoadClanDirectModules()
		if not Modules then
			RuntimeState.StateText = "클랜 서버 기능 준비 실패"
			return
		end
		ClanDirect.JoinRequested = false
		if DirectJoinClanServer(Modules) then
			RuntimeState.StateText = "클랜 서버 이동 요청 완료"
		else
			RuntimeState.StateText = "클랜 서버 이동 요청 실패"
		end
	end)
end)
UI.QuickAFKCancelRespawn.MouseButton1Click:Connect(function()
	UI.IntegratedQuickPopup.Visible = false

	-- AFK 자동진입을 먼저 끄지 않으면 리스폰 후 다시 패드로 돌아갑니다.
	RuntimeState.AFKEnabled = false
	RuntimeState.AFKInitialCollectDone = false
	RuntimeState.AFKNextCollectAt = nil
	RuntimeState.AFKNextIdleInputAt = nil
	RuntimeState.Working = false
	RuntimeState.RemainingTime = 0
	RuntimeState.BaseReturnGuardRunning = false
	StopCaptureMovement()
	SetFPSLimitEnabled(false)
	SetRendering(true)
	SetGameUIVisible(true)
	RuntimeState.StateText = "AFK 수동 취소, 캐릭터 리스폰 중"

	task.spawn(function()
		local Character = Player.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

		if not Humanoid then
			RuntimeState.StateText = "AFK 취소 실패: 캐릭터 없음"
			return
		end

		local Success = pcall(function()
			Humanoid.Sit = false
			Humanoid.Health = 0
			Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
		end)

		if not Success then
			pcall(function()
				Character:BreakJoints()
			end)
		end

		local NewCharacter = Player.CharacterAdded:Wait()
		NewCharacter:WaitForChild("HumanoidRootPart", 15)
		RuntimeState.StateText = "AFK 수동 취소·리스폰 완료"
	end)
end)

UI.QuickAutoUIOff.MouseButton1Click:Connect(function()
	RuntimeState.AutoGameUIOff60 = not RuntimeState.AutoGameUIOff60
	RuntimeState.StateText = RuntimeState.AutoGameUIOff60
		and "1분마다 게임 UI 자동 끄기 켜짐"
		or "1분마다 게임 UI 자동 끄기 꺼짐"
end)

task.spawn(function()
	local PausedForSpin = false
	while Running do
		if RuntimeState.SpinBusy
			and IntegratedBridge.IsFarmRunning
			and IntegratedBridge.IsFarmRunning()
			and not PausedForSpin then
			PausedForSpin = IntegratedBridge.PauseFarmForSpin()
			if PausedForSpin then
				ApplyFPSCap(30)
				SetFPSLimitEnabled(true)
				RuntimeState.StateText = "무료 스핀 우선 처리, 자동팜 일시정지"
			end
		elseif not RuntimeState.SpinBusy and PausedForSpin then
			task.wait(0.5)
			IntegratedBridge.ResumeFarmAfterSpin()
			ApplyFPSCap(15)
			SetFPSLimitEnabled(true)
			PausedForSpin = false
			RuntimeState.StateText = "스핀 완료, 자동팜 재개"
		end
		task.wait(0.1)
	end
end)

task.spawn(function()
	local LastPosition = nil
	local LastMovedAt = os.clock()
	local BoostedForStall = false
	local MovingAgainAt = nil

	while Running do
		local FarmRunning =
			IntegratedBridge.IsFarmRunning
			and IntegratedBridge.IsFarmRunning()

		if FarmRunning and not RuntimeState.SpinBusy then
			local Character = Player.Character
			local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
			local Seat = Humanoid and Humanoid.SeatPart
			local Position = Seat and Seat.Position

			if Position then
				if not LastPosition or (Position - LastPosition).Magnitude >= 3 then
					LastMovedAt = os.clock()
					if BoostedForStall then
						MovingAgainAt = MovingAgainAt or os.clock()
						if os.clock() - MovingAgainAt >= 5 then
							ApplyFPSCap(15)
							SetFPSLimitEnabled(true)
							BoostedForStall = false
							MovingAgainAt = nil
							RuntimeState.StateText = "차량 이동 정상화, FPS 15 복귀"
						end
					end
				elseif os.clock() - LastMovedAt >= 5 and not BoostedForStall then
					ApplyFPSCap(30)
					SetFPSLimitEnabled(true)
					BoostedForStall = true
					MovingAgainAt = nil
					RuntimeState.StateText = "이동 정체 감지, FPS 30 자동 전환"
				end
				LastPosition = Position
			else
				LastPosition = nil
				LastMovedAt = os.clock()
			end
		else
			LastPosition = nil
			LastMovedAt = os.clock()
			MovingAgainAt = nil
			if BoostedForStall and not RuntimeState.SpinBusy then
				ApplyFPSCap(15)
				SetFPSLimitEnabled(true)
				BoostedForStall = false
			end
		end

		task.wait(1)
	end
end)

task.spawn(function()
	while Running and UI.Gui and UI.Gui.Parent do
		if IntegratedBridge.RecoveryWriteVerified == true then
			RuntimeState.FarmRecoveryStatus = "복구기록: 저장 확인 완료"
		elseif IntegratedBridge.RecoveryWriteVerified == false then
			RuntimeState.FarmRecoveryStatus = "복구오류: " .. tostring(IntegratedBridge.RecoveryWriteError or "원인 미확인")
		end
		local ServerText, ServerColor = IntegratedServerText()
		UI.IntegratedServer.Text = ServerText
		UI.IntegratedServer.TextColor3 = ServerColor

		local CompactIdleText = RuntimeState.IdleStart
			and IntegratedFormatDuration(os.clock() - RuntimeState.IdleStart)
			or "시작 전"
		local ServerColorText = ServerDisplayState == "클랜서버"
			and "rgb(80,220,110)"
			or "rgb(255,85,85)"
		UI.IntegratedAccount.Text =
			Player.Name
			.. "    방치 " .. CompactIdleText
			.. '    <font color="' .. ServerColorText .. '">'
			.. ServerText .. "</font>"

		local CurrentDiamond = RuntimeState.CurrentDiamonds
			and FormatNumber(RuntimeState.CurrentDiamonds)
			or "확인 중"
		local ProfitText = RuntimeState.CurrentDiamonds
			and RuntimeState.StartDiamonds
			and FormatSignedNumber(RuntimeState.DiamondProfit)
			or "확인 중"

		local Snapshot = IntegratedBridge.GetFarmSnapshot and IntegratedBridge.GetFarmSnapshot() or nil
		local FarmRunning = Snapshot and Snapshot.Running
		local StateText = FarmRunning
			and tostring(Snapshot.StatusText or "자동공격 작동 중")
			or (RuntimeState.StateText or "대기")
		if IntegratedBridge.RecoveryWriteVerified == false then
			StateText = "복구 저장 실패 · " .. tostring(IntegratedBridge.RecoveryWriteError or "원인 미확인")
		end

		UI.IntegratedLine1.Text = "상태  " .. StateText
		local RecoveryStatusText = tostring(RuntimeState.FarmRecoveryStatus or "복구기록: 확인 불가")
		local RecoveryStatusColor = "rgb(255,210,70)"
		if string.find(RecoveryStatusText, "저장 확인 완료", 1, true)
		or string.find(RecoveryStatusText, "발견", 1, true) then
			RecoveryStatusColor = "rgb(65,255,105)"
		elseif string.find(RecoveryStatusText, "실패", 1, true)
		or string.find(RecoveryStatusText, "오류", 1, true)
		or string.find(RecoveryStatusText, "불일치", 1, true)
		or string.find(RecoveryStatusText, "기능 없음", 1, true) then
			RecoveryStatusColor = "rgb(255,70,70)"
		end
		local RecoveryShortText = string.gsub(RecoveryStatusText, "복구기록:%s*", "")
		UI.IntegratedRecovery.Text =
			'<font color="' .. RecoveryStatusColor .. '"><b>((복구기록: '
			.. RecoveryShortText .. "))</b></font>"
		UI.IntegratedLine2.Text =
			'<font color="rgb(190,110,255)"><b>현재 다이아  '
			.. CurrentDiamond .. "</b></font>"
			.. '    <font color="rgb(80,220,110)"><b>총수익  '
			.. ProfitText .. "</b></font>"
			.. '    <font color="rgb(255,205,70)"><b>스핀 총수익  '
			.. FormatNumber(RuntimeState.SpinDiamondProfit or 0) .. "</b></font>"

		local SpinText = RuntimeState.NextSpinAt
			and FormatTime(math.max(0, RuntimeState.NextSpinAt - os.clock()))
			or "확인 중"
		local AFKHealthy = RuntimeState.AFKEnabled
			and not RuntimeState.Working
			and not RuntimeState.SpinBusy
		local OperationText = StateText
		local OperationColor = Color3.fromRGB(80, 220, 110)

		if FarmRunning then
			OperationText = "자동팜 작동 중"
			OperationColor = Color3.fromRGB(80, 220, 110)
			UI.IntegratedLine3.Text =
				"자동팜 작동 중    차량  " .. tostring(Snapshot.VehicleName)
				.. "    작업  " .. IntegratedFormatDuration(Snapshot.WorkSeconds)
			UI.IntegratedFarmButton.Text = "자동팜 화면 열기"
			UI.IntegratedFarmButton.BackgroundColor3 = Color3.fromRGB(62, 82, 118)
		elseif RuntimeState.SpinBusy then
			OperationText = "스핀 처리 중"
			OperationColor = Color3.fromRGB(255, 210, 75)
			UI.IntegratedLine3.Text = "스핀 처리 중    다음 스핀  " .. SpinText
			UI.IntegratedFarmButton.Text = "자동팜 열기"
			UI.IntegratedFarmButton.BackgroundColor3 = Color3.fromRGB(62, 82, 118)
		elseif AFKHealthy then
			OperationText = "AFK 정상 작동"
			OperationColor = Color3.fromRGB(80, 145, 235)
			UI.IntegratedLine3.Text =
				"AFK 정상 작동    방치  " .. CompactIdleText
				.. "    다음 스핀  " .. SpinText
			UI.IntegratedFarmButton.Text = "자동팜 열기"
			UI.IntegratedFarmButton.BackgroundColor3 = Color3.fromRGB(62, 82, 118)
		else
			if string.find(StateText, "달성", 1, true)
				or string.find(StateText, "다음 차량", 1, true)
				or string.find(StateText, "전환", 1, true) then
				OperationColor = Color3.fromRGB(65, 210, 200)
			elseif string.find(string.lower(StateText), "오류", 1, true)
				or string.find(string.lower(StateText), "실패", 1, true) then
				OperationColor = Color3.fromRGB(255, 85, 85)
			elseif string.find(StateText, "복구", 1, true)
				or string.find(StateText, "재소환", 1, true) then
				OperationColor = Color3.fromRGB(255, 210, 75)
			else
				OperationColor = Color3.fromRGB(80, 145, 235)
			end
			UI.IntegratedLine3.Text =
				"대기 상태    방치  " .. CompactIdleText
				.. "    다음 스핀  " .. SpinText
			UI.IntegratedFarmButton.Text = "자동팜 열기"
			UI.IntegratedFarmButton.BackgroundColor3 = Color3.fromRGB(62, 82, 118)
		end

		local QueueCount = Snapshot and tonumber(Snapshot.QueueCount) or 0
		UI.IntegratedQueueTab.Text = "차량 대기열 " .. tostring(QueueCount)
		UI.IntegratedDetail1.Text = ""
		UI.IntegratedDetail2.Text = ""
		UI.IntegratedDetail3.Text = ""
		UI.IntegratedDetail4.Text = ""
		UI.IntegratedDetail3.RichText = false
		UI.IntegratedDetail3.TextSize = 11
		UI.IntegratedDetail3.Font = Enum.Font.Gotham
		UI.IntegratedDetail3.TextColor3 = Color3.fromRGB(210, 210, 220)

		if IntegratedCompactTab == "Queue" then
			local Pending = Snapshot and Snapshot.QueueEntries or {}
			if QueueCount <= 0 or type(Pending) ~= "table" or #Pending == 0 then
				UI.IntegratedDetail1.Text = "다음 대기 차량 없음"
				UI.IntegratedDetail2.Text = "자동팜 차량 선택 화면에서 대기열을 추가할 수 있습니다"
			else
				local DetailLabels = {
					UI.IntegratedDetail1,
					UI.IntegratedDetail2,
					UI.IntegratedDetail3,
				}
				for Index, Entry in ipairs(Pending) do
					if Index > 3 then break end
					DetailLabels[Index].Text = string.format(
						"다음 %d   %s   Lv%d → 목표 %s",
						Index,
						tostring(Entry.Name or "이름 없음"),
						tonumber(Entry.InitialLevel) or 0,
						IntegratedGoalLevelText(Entry.TargetLevel)
					)
				end
				UI.IntegratedDetail4.Text = QueueCount > 3
					and ("총 " .. tostring(QueueCount) .. "대 대기 · 외 " .. tostring(QueueCount - 3) .. "대")
					or ("총 " .. tostring(QueueCount) .. "대 대기 · 위에서부터 자동 진행")
			end
		elseif FarmRunning then
			UI.IntegratedDetail1.Text = "현재 차량   " .. tostring(Snapshot.VehicleName)
			UI.IntegratedDetail2.Text = string.format(
				"시작 레벨   %d  →  현재 %d  →  목표 %s",
				tonumber(Snapshot.InitialLevel) or 0,
				tonumber(Snapshot.Level) or 0,
				IntegratedGoalLevelText(Snapshot.GoalLevel)
			)
			UI.IntegratedDetail3.RichText = true
			UI.IntegratedDetail3.TextSize = 14
			UI.IntegratedDetail3.Font = Enum.Font.GothamBold
			UI.IntegratedDetail3.TextColor3 = Color3.fromRGB(255, 220, 80)
			UI.IntegratedDetail3.Text =
				'<b>작업 시간   ' .. IntegratedFormatDuration(Snapshot.WorkSeconds) .. "</b>"
			UI.IntegratedDetail4.Text = tonumber(Snapshot.GoalLevel) == 0
				and "무제한 파밍 중 · 다음 차량 자동 전환 안 함"
				or QueueCount > 0
				and ("다음 대기 차량 " .. tostring(QueueCount) .. "대")
				or "다음 대기 차량 없음"
		else
			UI.IntegratedDetail1.Text = "자동팜 대기 중"
			UI.IntegratedDetail2.Text = "팜을 시작하면 차량과 시작 레벨을 표시합니다"
			UI.IntegratedDetail3.Text = "현재 상태   " .. tostring(StateText)
			UI.IntegratedDetail4.Text = QueueCount > 0
				and ("다음 대기 차량 " .. tostring(QueueCount) .. "대")
				or "다음 대기 차량 없음"
		end

		UI.IntegratedLine1.TextColor3 = OperationColor
		local BothOn = RuntimeState.RenderingEnabled and RuntimeState.GameUIVisible
		UI.IntegratedMainButton.Text = BothOn and "3D + UI 끄기" or "3D + UI 켜기"
		UI.QuickAutoUIOff.Text = RuntimeState.AutoGameUIOff60
			and "1분 UI 자동끄기: 켜짐"
			or "1분 UI 자동끄기: 꺼짐"
		UI.QuickAutoUIOff.BackgroundColor3 = RuntimeState.AutoGameUIOff60
			and Color3.fromRGB(50, 125, 80)
			or Color3.fromRGB(75, 75, 86)
		UI.QuickServerAction.Text = ServerDisplayState == "클랜서버"
			and "다이아 다시 확인"
			or "클랜 서버 입장"

		UI.V11AccountCard.Text =
			"계정·서버\n" .. Player.Name
			.. "\n" .. ServerText .. " · 방치 " .. CompactIdleText
		UI.V11StateCard.Text = "현재 운용 상태\n● " .. OperationText .. "\n다음 스핀 " .. SpinText
		UI.V11StateCard.TextColor3 = OperationColor
		UI.V11DiamondCard.Text =
			"다이아\n현재 " .. CurrentDiamond
			.. "\n총수익 " .. ProfitText
		if FarmRunning then
			UI.V11FarmCard.Text =
				"자동팜 작동 중\n" .. tostring(Snapshot.VehicleName)
				.. " · 레벨 " .. tostring(Snapshot.Level)
				.. " → " .. IntegratedGoalLevelText(Snapshot.GoalLevel)
				.. "\n작업 " .. IntegratedFormatDuration(Snapshot.WorkSeconds)
				.. " · " .. tostring(Snapshot.StatusText or "정상 작동")
			UI.V11Farm.Text = "자동팜 화면 열기"
			UI.V11Farm.BackgroundColor3 = Color3.fromRGB(62, 82, 118)
		else
			UI.V11FarmCard.Text = "자동팜 대기\nAFK " .. (AFKHealthy and "정상 작동" or "대기") .. "\n대기 차량 확인"
			UI.V11Farm.Text = "자동팜 열기"
			UI.V11Farm.BackgroundColor3 = Color3.fromRGB(62, 82, 118)
		end
		UI.V11CaptureState.Text = "현재 상태: " .. OperationText .. "    AFK: " .. (AFKHealthy and "정상" or "대기")
		UI.V11CaptureState.TextColor3 = OperationColor
		UI.V11SpinInfo.Text =
			"다음 스핀: " .. SpinText
			.. "\n수집 횟수: " .. tostring(RuntimeState.AFKRewardState.CollectCount or 0) .. "회"
			.. "\n상태: " .. tostring(RuntimeState.SpinStatus or "자동 확인 대기")
		UI.V11SpinToggle.Text = RuntimeState.AutoSpinEnabled and "자동 스핀: 켜짐" or "자동 스핀: 꺼짐"
		UI.V11SpinToggle.BackgroundColor3 = RuntimeState.AutoSpinEnabled
			and Color3.fromRGB(50, 125, 80) or Color3.fromRGB(75, 75, 86)
		UI.V11SettingsInfo.Text =
			"FPS 제한: " .. (FPS_ENABLED and (tostring(Settings.FPS_CAP) .. " · 켜짐") or "꺼짐")
			.. "\n1분 UI 자동끄기: " .. (RuntimeState.AutoGameUIOff60 and "켜짐" or "꺼짐")
			.. "\n3D 렌더링: " .. (RuntimeState.RenderingEnabled and "켜짐" or "꺼짐")
		UI.V11FPS.Text = FPS_ENABLED and ("FPS " .. tostring(Settings.FPS_CAP) .. " · 켜짐") or "FPS 제한 · 꺼짐"
		UI.V11AutoUI.Text = RuntimeState.AutoGameUIOff60 and "1분 UI 자동끄기 · 켜짐" or "1분 UI 자동끄기 · 꺼짐"

		task.wait(0.5)
	end
end)

-- 통합 메인 UI 모바일 분기. PC에서는 V3.7 배치를 그대로 유지합니다.
-- 새 최상위 local을 늘리지 않도록 관련 상태와 함수는 UI.Mobile에 묶습니다.
UI.Mobile = {
	Enabled = UserInputService.TouchEnabled,
	DesignWidth = 442,
	DesignHeight = 308,
	Drags = {},
	UserMovedMain = false,
	UserMovedConfirm = false,
	UserMovedQuick = false,
	UserMovedFPS = false,
	UserMovedLegacyQuick = false,
}

if UI.Mobile.Enabled then
	UI.Gui.IgnoreGuiInset = false
	UI.Mobile.ConfirmScale = Instance.new("UIScale")
	UI.Mobile.ConfirmScale.Parent = UI.IntegratedConfirm
	UI.Mobile.QuickScale = Instance.new("UIScale")
	UI.Mobile.QuickScale.Parent = UI.IntegratedQuickPopup

	UI.IntegratedQuickClose.Size = UDim2.fromOffset(44, 40)
	UI.IntegratedQuickClose.Position = UDim2.new(1, -52, 0, 7)
	UI.IntegratedQuickClose.TextSize = 18
	UI.CloseButton.Size = UDim2.fromOffset(44, 40)
	UI.CloseButton.Position = UDim2.new(1, -48, 0, 2)
	UI.CloseButton.TextSize = 18
	UI.MinimizeButton.Size = UDim2.fromOffset(44, 40)
	UI.MinimizeButton.Position = UDim2.new(1, -96, 0, 2)

	UI.Mobile.ClampWindow = function(Window)
		if not Window or not Window.Parent then return end
		local Camera = Workspace.CurrentCamera
		local Viewport = Camera and Camera.ViewportSize or Vector2.new(1440, 3040)
		local ParentPosition = Window.Parent:IsA("GuiObject") and Window.Parent.AbsolutePosition or Vector2.new(0, 0)
		local Position = Window.AbsolutePosition
		local Size = Window.AbsoluteSize
		local Margin = 10
		local X = math.clamp(Position.X, Margin, math.max(Margin, Viewport.X - Size.X - Margin))
		local Y = math.clamp(Position.Y, Margin, math.max(Margin, Viewport.Y - Size.Y - Margin))
		Window.Position = UDim2.fromOffset(X - ParentPosition.X, Y - ParentPosition.Y)
	end

	UI.Mobile.BindTitleDrag = function(Window, Handle, MovedKey)
		if not Window or not Handle then return end
		Handle.Active = true
		local Drag = {Active = false, Input = nil, StartPointer = nil, StartWindow = nil}
		table.insert(UI.Mobile.Drags, Drag)
		Handle.InputBegan:Connect(function(Input)
			if Input.UserInputType ~= Enum.UserInputType.Touch
			and Input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
			Drag.Active = true
			Drag.Input = Input
			Drag.StartPointer = Vector2.new(Input.Position.X, Input.Position.Y)
			Drag.StartWindow = Window.AbsolutePosition
		end)
		UserInputService.InputChanged:Connect(function(Input)
			if not Drag.Active or Input ~= Drag.Input then return end
			local Pointer = Vector2.new(Input.Position.X, Input.Position.Y)
			local Delta = Pointer - Drag.StartPointer
			local Camera = Workspace.CurrentCamera
			local Viewport = Camera and Camera.ViewportSize or Vector2.new(1440, 3040)
			local Size = Window.AbsoluteSize
			local Margin = 10
			local Target = Drag.StartWindow + Delta
			local X = math.clamp(Target.X, Margin, math.max(Margin, Viewport.X - Size.X - Margin))
			local Y = math.clamp(Target.Y, Margin, math.max(Margin, Viewport.Y - Size.Y - Margin))
			local ParentPosition = Window.Parent:IsA("GuiObject") and Window.Parent.AbsolutePosition or Vector2.new(0, 0)
			Window.Position = UDim2.fromOffset(X - ParentPosition.X, Y - ParentPosition.Y)
			UI.Mobile[MovedKey] = true
		end)
		UserInputService.InputEnded:Connect(function(Input)
			if Input == Drag.Input then
				Drag.Active = false
				Drag.Input = nil
				UI.Mobile.ClampWindow(Window)
			end
		end)
	end

	UI.Mobile.ApplyViewport = function()
		local Camera = Workspace.CurrentCamera
		local Viewport = Camera and Camera.ViewportSize or Vector2.new(1440, 3040)
		local Landscape = Viewport.X > Viewport.Y
		local HeightLimit = Landscape and 0.74 or 0.82
		local MainScale = math.clamp(math.min(
			(Viewport.X * 0.90) / UI.Mobile.DesignWidth,
			(Viewport.Y * HeightLimit) / UI.Mobile.DesignHeight
		), 0.62, 3.2)

		UI.MainScale.Scale = MainScale
		if not UI.Mobile.UserMovedMain then
			UI.Main.Position = UDim2.new(
				0.5, -(UI.Mobile.DesignWidth * MainScale * 0.5),
				0.5, -(UI.Mobile.DesignHeight * MainScale * 0.5)
			)
		end

		local ConfirmScale = math.clamp(math.min(
			(Viewport.X * 0.92) / 390,
			(Viewport.Y * 0.82) / 170
		), 0.75, 3.2)
		UI.Mobile.ConfirmScale.Scale = ConfirmScale
		if not UI.Mobile.UserMovedConfirm then
			UI.IntegratedConfirm.Position = UDim2.new(0.5, -(390 * ConfirmScale * 0.5), 0.5, -(170 * ConfirmScale * 0.5))
		end

		local QuickScale = math.clamp(math.min(
			(Viewport.X * 0.92) / 390,
			(Viewport.Y * 0.82) / 300
		), 0.75, 3.2)
		UI.Mobile.QuickScale.Scale = QuickScale
		if not UI.Mobile.UserMovedQuick then
			UI.IntegratedQuickPopup.Position = UDim2.new(0.5, -(390 * QuickScale * 0.5), 0.5, -(300 * QuickScale * 0.5))
		end
		task.defer(function()
			UI.Mobile.ClampWindow(UI.Main)
			UI.Mobile.ClampWindow(UI.IntegratedConfirm)
			UI.Mobile.ClampWindow(UI.IntegratedQuickPopup)
			UI.Mobile.ClampWindow(UI.FPSPopup)
			UI.Mobile.ClampWindow(UI.QuickPopup)
		end)
	end

	UI.Mobile.BindCamera = function(Camera)
		if UI.Mobile.ViewportConnection then UI.Mobile.ViewportConnection:Disconnect() end
		if Camera then
			UI.Mobile.ViewportConnection = Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UI.Mobile.ApplyViewport)
		end
		UI.Mobile.ApplyViewport()
	end

	UI.Mobile.CameraConnection = Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
		UI.Mobile.BindCamera(Workspace.CurrentCamera)
	end)

	UI.Mobile.OriginalSetCompactMode = UI.SetCompactMode
	UI.SetCompactMode = function(State)
		UI.Mobile.OriginalSetCompactMode(State)
		UI.Mobile.ApplyViewport()
	end
	UI.Mobile.BindTitleDrag(UI.Main, UI.Title, "UserMovedMain")
	UI.Mobile.BindTitleDrag(UI.IntegratedConfirm, UI.IntegratedConfirmTitle, "UserMovedConfirm")
	UI.Mobile.BindTitleDrag(UI.IntegratedQuickPopup, UI.IntegratedQuickTitle, "UserMovedQuick")
	UI.Mobile.BindTitleDrag(UI.FPSPopup, UI.FPSTitle, "UserMovedFPS")
	UI.Mobile.BindTitleDrag(UI.QuickPopup, UI.QuickTitle, "UserMovedLegacyQuick")
	UI.Mobile.BindCamera(Workspace.CurrentCamera)
end

UI.SetCompactMode(true)

