property city : "Dublin"
property state : "CA"
property units : "english" -- english, metric
property round_to_nearest : 1 -- 1, 10, 0.5, 0.25, ...

do shell script "curl -qsL " & quoted form of ("http://rss.wunderground.com/auto/rss_full/" & state & "/" & city & ".xml?units=" & units) & " | grep 'Temperature:' | awk -F': ' '{print $2}' | awk -F'&' '{print $1}' "
say ((round result / round_to_nearest) * round_to_nearest as text) & "¡"