on run {input, parameters}
	set projectName to "ProjectName"
	set projectSlug to "project_slug"
	set projectUrl to "http://localhost:8000/"
	set projectBoard to "https://trello.com/b/xxxxxxxx/sampleboard"

	set projectFolder to "~/Documents/Work/" & projectName &  "/" & projectSlug & ".prj/"

	tell application "iTerm"
		tell the first terminal
			tell the last session
				write text "cd " & projectFolder
				write text "source .env/bin/activate"
				write text "./manage.py runserver 0.0.0.0:8000"
				set the name to projectName & ": Runserver"
			end tell

			launch session "Default Session"
			tell the last session
				write text "cd " & projectFolder
				write text "source .env/bin/activate"
				write text "gitx"
				write text "clear"
				set the name to projectName & ": Shell"
			end tell
		end tell

		set the name of the first window to projectName

		activate

	end tell


	tell application "Google Chrome"
		if (count of windows) is 0 or front window is not visible then
			make new window
		end if
		set myTab to the first tab of front window
		set URL of myTab to projectUrl

		set myTab2 to make new tab at end of tabs of front window
		set URL of myTab2 to projectBoard

		activate

		tell application "System Events"
			keystroke "1" using command down
			keystroke "r" using {command down, shift down}
		end tell
	end tell

	set command to "/usr/local/bin/subl " & projectFolder & projectSlug & ".sublime-project"
	do shell script command
	do shell script "open -a 'Time Tracker'"

	return input
end run
