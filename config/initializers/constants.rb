DEVELOPER_EMAIL = %("Kevin Skoglund" <kevin@novafabrica.com>)

STANDARD_EMAIL_REGEX = /\A([a-z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-z0-9\-]+\.)+))([a-z]{2,4}|[0-9]{1,3})(\]?)\z/i

Time::DATE_FORMATS[:standard] = "%B %e, %Y at %l:%M %p %Z"
Time::DATE_FORMATS[:date_only] = "%-m/%-d/%y"
Time::DATE_FORMATS[:condensed] = "%-m/%-d/%y %-H:%M"
Time::DATE_FORMATS[:month_and_year] = "%-m/%y"

Date::DATE_FORMATS[:standard] = "%B %e, %Y"
Date::DATE_FORMATS[:date_only] = "%-m/%-d/%Y"
