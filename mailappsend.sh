#!/bin/bash

while getopts s:c:f:a:t:xh OPT; do
    case $OPT in
        h)
            echo "Simple CLI utility to create a mail in apple mail"
            echo "-s text	set the subject of the mail"
            echo "-c text	set the content of the mail"
            echo "-f path	specify a file containing the content of the mail"
            echo "-a path	set an attachment"
            echo "-t text	set the recipient mail address"
            echo "-x		send the mail after creating it"		
            echo "-h		print this help and exit"
            echo ""
            exit
        ;;

        s)
            SUBJECT=$OPTARG
        ;;

        c)
            CONTENT=$OPTARG
        ;;

        f)
            CONTENTFILE=$OPTARG
        ;;

        a)
            ATTACHMENT=$OPTARG
        ;;

        t)
            TO=$OPTARG
        ;;

        x)
            SEND="send"
        ;;
    esac
done

if [[ -n "$CONTENTFILE" ]]; then
	CONTENT=`cat "$CONTENTFILE"`
fi

SCRIPT="set recipientAddress to \""$TO"\"\n"
SCRIPT="$SCRIPT set theSubject to \""$SUBJECT"\"\n"
SCRIPT="$SCRIPT set theContent to \""$CONTENT"\"\n"
SCRIPT="$SCRIPT tell application \"Mail\"\n"
if [[ -n "$ATTACHMENT" ]]; then
    if [ "$(echo $ATTACHMENT | head -c 1)" != "/" ]; then
     ATTACHMENT="`pwd -P`/$ATTACHMENT"
 fi
 echo "$ATTACHMENT"
 SCRIPT="$SCRIPT set theAttachment to POSIX file \""$ATTACHMENT"\"\n"
fi
SCRIPT="$SCRIPT set theMessage to make new outgoing message with properties {subject:theSubject, content:theContent, visible:true}\n"
SCRIPT="$SCRIPT tell theMessage\n"
SCRIPT="$SCRIPT make new to recipient with properties {address:recipientAddress}\n"
if [[ -n "$ATTACHMENT" ]]; then
	SCRIPT="$SCRIPT make new attachment with properties {file name:theAttachment} at after the last paragraph\n"
fi
SCRIPT="$SCRIPT "$SEND"\n"
SCRIPT="$SCRIPT end tell\n"
SCRIPT="$SCRIPT end tell"

echo -e "$SCRIPT" | osascript