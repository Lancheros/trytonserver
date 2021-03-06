#!/bin/bash
# vars

databases="
name_db
"
current_date_time="`date +%Y%m%d%H%M%S`";

# dump
for database in ${databases}
    do
        backups_path="var/lib/postgresql/backups/$database"
        pg_dump $database > $backups_path/$current_date_time.sql;
    
        # get size of dump
        size="`wc -c $backups_path/$current_date_time.sql`";

        # get oldest backup
        first_backup="`ls $backups_path | sort -n | head -1`"
        echo 'first backup '$first_backup

        # get size of oldest backup
        size_first="`wc -c $backups_path/$first_backup`"
        echo 'size_first '$size_first

        # get backups count
        backups_count="`find  $backups_path/*.sql -type f | wc -l`"
        echo 'backups_count '$backups_count

        # printing subject for email
        echo 'Subject:'$size >  $backups_path/$current_date_time.txt

        # condition for remove if there is more than 4 backups
        if [ $backups_count -ge 8 ] ; then
        echo 'Greather than 8'

        # removing backup
        rm $backups_path/$first_backup
        first_text="`ls $backups_path | sort -n | head -1`"
        
        # removing text of backup
        rm $backups_path/$first_text
        
        # printing body explaining removed backup
        printf "\nArchivo borrado: "$first_backup >>  $backups_path/$current_date_time.txt
        printf "\nPeso: "$size_first >>  $backups_path/$current_date_time.txt
        fi

        # sending email
        #curl --url 'smtps://smtp.gmail.com:465' --ssl-reqd --mail-from 'notificaciones@cdstecno.com' --mail-rcpt 'clancheros@cdstecno.com' --upload-file $backups_path/$current_date_time.txt --user 'notificaciones@cdstecno.com:98642443.Asd' --insecure
    done
