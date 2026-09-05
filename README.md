# 쇼타임 Loader 공개 배포 저장소

이 저장소는 실행기에서 긴 Lua를 직접 붙여넣지 않도록 승인된 배포본을 제공하는 용도입니다.

## 모바일 운영 규칙

- 고정 진입점은 승인된 전체 Lua가 들어 있는 `mobile/latest.lua`입니다.
- 승인된 전체 모바일 코드는 `mobile/versions/`에도 동일하게 보관합니다.
- 새 시험본은 버전 파일로만 추가하며 `mobile/latest.lua`를 변경하지 않습니다.
- 사용자가 정확히 **모바일 최신화해줘**라고 승인한 경우에만 승인된 버전 전체 Lua를 `mobile/latest.lua`에 그대로 복사합니다.
- 승격할 때 `mobile/latest.lua`와 승인된 버전 파일의 SHA-256 일치를 확인합니다.
- 모바일 최신화는 `pc/`에 영향을 주지 않습니다.
- PC 최신화는 `mobile/`에 영향을 주지 않습니다.
- 롤백할 때는 이전 승인본 전체 Lua를 `mobile/latest.lua`에 다시 적용하고 SHA-256 일치를 확인합니다.

## 모바일 고정 Loader

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/wwwshow1-design/showtime-mobile-loader/main/mobile/latest.lua"))()
```

## 공개 범위

`raw.githubusercontent.com` 주소로 내려받는 파일은 누구나 열람할 수 있습니다. 한 줄 Loader는 소스 코드를 암호화하거나 보호하지 않습니다.

