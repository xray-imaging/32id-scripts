#!/bin/bash

# === Configuration ===
TO="amittone@anl.gov"
SUBJECT="He Box threshold"
LOGFILE="/tmp/trigger_email.log"

# === Trigger function ===
check_and_send() {
    # Read PVs
    AO1=$(caget -t 32idbSoft:PLC1:ao1 2>/dev/null)
    HE1=$(caget -t 32idbTXM:he1:calc 2>/dev/null)

    # Ensure both values are non-empty and numeric
    if [[ ! $AO1 =~ ^-?[0-9]*\.?[0-9]+$ ]] || [[ ! $HE1 =~ ^-?[0-9]*\.?[0-9]+$ ]]; then
        echo "$(date): ERROR - Invalid PV values: AO1='$AO1' HE1='$HE1'" >> "$LOGFILE"
        return
    fi

    echo "$(date): AO1=$AO1 HE1=$HE1" >> "$LOGFILE"

    # Condition
    if (( $(echo "$AO1 != 0" | bc -l) )) && (( $(echo "$HE1 < 50" | bc -l) )); then
        {
            echo "To: $TO"
            echo "From: $TO"
            echo "Subject: $SUBJECT"
            echo ""
            echo -e "Trigger condition met:\nAO1 = $AO1\nHE1 = $HE1"
        } | sendmail -t

        echo "$(date): Email sent." >> "$LOGFILE"
    else
        echo "$(date): Condition not met." >> "$LOGFILE"
    fi
}

# === Loop every 20 minutes ===
while true; do
    check_and_send
    sleep 1200  # 20 minutes
done

