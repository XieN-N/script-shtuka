#!/bin/bash
function f_start {
        echo "Please, select the number of the command you are interested in: "
        echo "1. Information about the current user and OS version"
        echo "2. List of all files with access rights in the current user's home directory"
        echo "3. Create a file with certain rights in a certain directory"
        echo "4. Send n packets using ping to a certain resource"
        echo "5. Close the script"
        read answer
        if [ "$answer" -gt 5 ] || [ "$answer" -lt 1 ]; then
        echo "You have selected number that is not in the list, try again:"
        echo "------------------------------------------------------------"
        f_start
        fi
}

function f_1 {
        echo "Current user: "
        whoiam
        echo ""
        echo "OS version: "
        cat /proc/version
}

function f_2 {
        if [ "$USER" == "root" ]; then
        ls -la /$USER
        else
        ls -la /home/$USER
        fi
}

function f_3 {
        echo "Enter file name. For example: elephant"
        read file_name
        echo ""
        echo "Enter the absolute path to the directory where you want to add the file. For example: /home/user1/qu1"
        read file_path
        echo ""
        echo "Enter the numeric value of the access rights. For example: 755"
        read file_rights
        echo ""
        mkdir "$file_path"
        touch "$file_path"/"$file_name"
        chmod "$file_rights" "$file_path"/"$file_name"
        echo ""
        echo "The file $file_name has been created. Path to it: $file_path/$file_name"
        ls -l "$file_path"
}

function f_4 {
        echo "Enter the number of packets to be sent:"
        read package_number
        echo ""
        echo "Enter a link to the resource to which you want to send packages:"
        read resource
        echo ""
        if [ -z "$package_number" ] || [ -z "$resource" ]; then
         echo "You left the number of packages or link to the resource empty. Try again:"
         f_4
        fi
        ping -c "$package_number" "$resource" 
}
 
function f_5 {
        echo "Exiting the script..."
        exit
}

f_start

echo "Selected command number:" $answer
echo "------------------------------------------------------------"

if [ "$answer" -eq 1 ]; then
 f_1
elif [ "$answer" -eq 2 ]; then
 f_2
elif [ "$answer" -eq 3 ]; then
 f_3
elif [ "$answer" -eq 4 ]; then
 f_4
elif [ "$answer" -eq 5 ]; then
 f_5
fi