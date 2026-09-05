-- 쇼타임 모바일 승인본 Loader
-- 이 파일은 사용자가 "모바일 최신화해줘"라고 명확히 승인했을 때만 변경합니다.

local VERSION = "V3.8"
local VERSION_URL = "https://raw.githubusercontent.com/wwwshow1-design/showtime-mobile-loader/main/mobile/versions/V3.8.lua"

local downloadOk, source = pcall(function()
    return game:HttpGet(VERSION_URL)
end)

if not downloadOk or type(source) ~= "string" or source == "" then
    warn("[쇼타임 모바일] 최신 스크립트를 불러오지 못했습니다.")
    warn("[쇼타임 모바일] 인터넷 연결 또는 배포 주소를 확인해주세요.")
    error("[쇼타임 모바일] " .. VERSION .. " 다운로드 실패: " .. tostring(source))
end

local chunk, compileError = loadstring(source)
if not chunk then
    warn("[쇼타임 모바일] 내려받은 스크립트를 실행 준비하지 못했습니다.")
    error("[쇼타임 모바일] " .. VERSION .. " 문법 확인 실패: " .. tostring(compileError))
end

local runOk, runError = pcall(chunk)
if not runOk then
    warn("[쇼타임 모바일] 스크립트 실행 중 오류가 발생했습니다.")
    error("[쇼타임 모바일] " .. VERSION .. " 실행 실패: " .. tostring(runError))
end

