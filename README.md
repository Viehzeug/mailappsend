mailappsend
===========

Send mails with OS X's Mail.app from the terminal.
Note: The tool actually just creates the mail in Mail.app. To send it you need to use the -x option.


Usage
-----------

  marc@MFMBP ~ $ mailappsend -h
  Simple CLI utility to create a mail in apple mail
  -s text  set the subject of the mail
  -c text	set the content of the mail
  -f path	specify a file containing the content of the mail
  -a path	set an attachment
  -t text	set the recipient mail address
  -x		send the mail after creating it
  -h		print this help and exit


Install
-----------

  curl https://raw.github.com/Viehzeug/mailappsend/master/mailappsend.sh -o /usr/local/bin/mailappsend && chmod +x /usr/local/bin/mailappsend
