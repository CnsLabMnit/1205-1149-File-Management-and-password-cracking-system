#!/bin/bash

banner OSS LAB PROJECT

encrypt_password() {
    local password="$1"
    local salt="$2"
    openssl passwd -6 -salt "$salt" "$password"
}


crack_password() {
    local target_encrypted_password="$1"
    local salt="$2"

    for a in {a..z}; do
        for b in {a..z}; do
            for c in {a..z}; do
                for d in {a..z}; do
                    local password="$a$b$c$d"
                    local generated_encrypted_password=$(openssl passwd -6 -salt "$salt" "$password")

                    if [ "$target_encrypted_password" = "$generated_encrypted_password" ]; then
                        echo "Password found: $password"
                        return 0
                    fi
                done
            done
        done
    done

    echo "Password not found"
    return 1
}

 encrypt_and_save_password() {
    clear
    echo "Enter password to encrypt: "
    read  password
    echo "Enter salt: "
    read salt

    encrypted_password=$(encrypt_password "$password" "$salt")

    echo "Enter filename to save encrypted password: "
    read filename

    echo "$encrypted_password" > "$filename"

    echo "Password encrypted and saved to file: $filename"
    echo "Press Enter to return to the main menu..."
    read
}


# Function to crack password from file
crack_password_from_file() {
    clear
    echo "Enter filename containing encrypted password: "
    read filename

    if [ ! -f "$filename" ]; then
        echo "File not found: $filename"
        echo "Press Enter to return to the main menu..."
        read
        return
    fi

    echo "Enter salt: "
    read salt

    target_encrypted_password=$(cat "$filename")

    crack_password "$target_encrypted_password" "$salt"
    echo "Press Enter to return to the main menu..."
    read
}

i="0"

while [ $i -lt 100 ]
do
    gcc project.c -o proj
    ./proj
    read -p "Enter your choice: " opt1

    case $opt1 in
        1)
            echo "Listing all files and directories..."
            sleep 3
            echo "Loading..."
            sleep 3
            echo "-------------------------------Output-------------------------"
            ls
            echo " "
            ;;
        2)
            echo "Creating new files..."
            echo "Which type of file do you want to create?"
            echo "1- .c"
            echo "2- .sh"
            echo "3- .txt"
            read -p "Enter your choice from 1-3: " filechoice

            case $filechoice in
                1)
                    read -p "Enter file name without .c extension: " filename
                    touch "$filename.c"
                    echo "-------------------------------Output-------------------------"
                    echo "File created successfully"
                    echo " "
                    ;;
                2)
                    read -p "Enter file name without .sh extension: " filename2
                    touch "$filename2.sh"
                    echo "-------------------------------Output-------------------------"
                    echo "File created successfully"
                    echo " "
                    ;;
                3)
                    read -p "Enter file name without .txt extension: " filename3
                    touch "$filename3.txt"
                    echo "-------------------------------Output-------------------------"
                    echo "File created successfully"
                    echo " "
                    ;;
                *)
                    echo "Invalid input.. Try again."
                    echo " "
                    ;;
            esac
            ;;
        3)
            echo "Deleting existing files..."
            read -p "Enter name of file you want to delete (please enter full name with extension): " delfile
            echo "-------------------------------Output-------------------------"
            if [ -f "$delfile" ]; then
                rm "$delfile"
                echo "Successfully deleted."
                echo " "
            else
                echo "File does not exist. Try again."
                echo " "
            fi
            ;;
        4)
            echo "Renaming files..."
            read -p "Enter old file name with extension: " old
            if [ -f "$old" ]; then
                read -p "Enter new file name with extension: " new
                mv "$old" "$new"
                echo "-------------------------------Output-------------------------"
                echo "File successfully renamed to $new"
                echo " "
            else
                echo "$old does not exist. Try again with correct filename."
                echo " "
            fi
            ;;
        5)
            echo "Editing file content..."
            read -p "Enter file name with extension: " edit
            echo "-------------------------------Output-------------------------"
            if [ -f "$edit" ]; then
                nano "$edit"
                echo " "
            else
                echo "$edit does not exist. Try again."
                echo " "
            fi
            ;;
        6)
            echo "Searching for files..."
            read -p "Enter file name with extension to search: " f
            echo "-------------------------------Output-------------------------"
            if [ -f "$f" ]; then
                echo "Searching for $f file"
                echo "File found:"
                find /home -name "$f"
                echo " "
            else
                echo "File does not exist. Try again."
                echo " "
            fi
            ;;
        7)
            echo "Displaying file details..."
            read -p "Enter file name with extension to see details: " detail
            echo "-------------------------------Output-------------------------"
            if [ -f "$detail" ]; then
                echo "File properties:"
                stat "$detail"
                echo " "
            else
                echo "$detail does not exist. Try again."
                echo " "
            fi
            ;;
        8)
            echo "Viewing file content..."
            read -p "Enter file name: " readfile
            echo "-------------------------------Output-------------------------"
            if [ -f "$readfile" ]; then
                echo "File content:"
                cat "$readfile"
                echo " "
            else
                echo "$readfile does not exist."
                echo " "
            fi
            ;;
        9)
            echo "Sorting file content..."
            read -p "Enter file name with extension to sort: " sortfile
            echo "-------------------------------Output-------------------------"
            if [ -f "$sortfile" ]; then
                echo "Sorted file content:"
                sort "$sortfile"
                echo " "
            else
                echo "$sortfile does not exist. Try again."
                echo " "
            fi
            ;;
        10)
            echo "Listing all directories..."
            echo "-------------------------------Output-------------------------"
            echo "Showing all directories..."
            echo "Loading..."
            sleep 3
            ls -d */
            echo " "
            ;;
        11)
            echo "Listing files with particular extensions..."
            echo "Which type of file list do you want to see?"
            echo "1- .c"
            echo "2- .sh"
            echo "3- .txt"
            read -p "Enter your choice from 1-3: " extopt
            echo "-------------------------------Output-------------------------"
            case $extopt in
                1)
                    echo "List of .c files:"
                    echo "Loading..."
                    sleep 3
                    ls *.c
                    echo " "
                    ;;
                2)
                    echo "List of .sh files:"
                    echo "Loading..."
                    sleep 3
                    ls *.sh
                    echo " "
                    ;;
                3)
                    echo "List of .txt files:"
                    echo "Loading..."
                    sleep 3
                    ls *.txt
                    echo " "
                    ;;
                *)
                    echo "Invalid input.. Try again."
                    echo " "
                    ;;
            esac
            ;;
        12)
            echo "Counting total number of directories..."
            echo "Loading all directories..."
            echo "Counting..."
            sleep 3
            echo "-------------------------------Output-------------------------"
            echo "Number of directories:"
            echo "$(ls -d */ | wc -w)"
            echo " "
            ;;
        13)
            echo "Counting total number of files in current directory..."
            echo "Loading all files..."
            sleep 3
            echo "-------------------------------Output-------------------------"
            echo "Number of files:"
            echo "$(ls -l | grep -v 'total' | grep -v '^d' | wc -l)"
            echo " "
            ;;
        14)
            echo "Sorting files..."
            echo "Your request for sorting files is being processed..."
            echo "Sorting..."
            sleep 3
            echo "-------------------------------Output-------------------------"
            ls | sort
            echo " "
            ;;
        15) 
            encrypt_and_save_password
            ;;
        16) 
            crack_password_from_file
            ;;
            
            
        0)
            echo "Goodbye.."
            echo "Successfully exited."
            break
            ;;
        *)
            echo "Invalid input.. Try again."
            ;;
    esac

    i=$((i+1))
    
   

done
