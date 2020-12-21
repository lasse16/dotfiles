new() { 
	if [[ "$#" ]] ; then
		case $1 in
			"python" )
				shift 
				path=$1
				mkdir -p "$path"
				cd "$path"||exit
				echo "layout_python python3" > .envrc
				direnv allow .
				echo ".envrc" > .gitignore
				echo ".direnv" >> .gitignore
				git init
				__create_python_hello_world
				git add . 
				git c -m "Initial repository created"
				echo "python project  created" 
				echo "Check if the required packages for vim are enabled"
				return 0
				;;
		esac
	fi
}

__create_python_hello_world() {
	cat > main.py <<EOF
#!/usr/bin/env python

def main():
	print("Hello World")


if __name__ == "__main__":
	main()
EOF
}

