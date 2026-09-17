local base="https://raw.githubusercontent.com/wwwshow1-design/showtime-mobile-loader/main/market-scanner/v3.4.0/"
local parts={}
for i=1,12 do
    local url=base..string.format("part%02d.txt",i)
    local ok,data
    for attempt=1,3 do
        ok,data=pcall(function() return game:HttpGet(url) end)
        if ok and type(data)=="string" and #data>0 then break end
        task.wait(0.5)
    end
    if not ok or type(data)~="string" or #data==0 then
        error("Market Scanner loader: part "..i.." download failed")
    end
    parts[i]=data
end
local source=table.concat(parts)
local fn,err=loadstring(source)
if not fn then error("Market Scanner loader compile error: "..tostring(err)) end
return fn()
