rootDir=$(pwd)
repositories=(replay common crypto o3e-packaging mr)
for repository in "${repositories[@]}" 
do 
	cd "$rootDir/$repository"
	ref=$(git symbolic-ref HEAD)
	branch=$(basename $ref)
	upstream=$(git for-each-ref --format='%(upstream:short)' $ref)
	echo -e "\e[32m$repository:\e[39m"	
	echo -e "\tFetching \e[32mupstream\e[39m"
	git fetch upstream
	echo -e "\tRebasing \e[32m$branch \e[39mon the top of \e[32m$upstream\e[0m"
	output=$(git rebase)
	output='\t\t'${output//$'\n'/'\n\t\t'}
	echo -e "$output"
done
echo -e "\e[32mdone"
read
