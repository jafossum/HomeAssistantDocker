# Pull the latest remote images, restart and optionally clean the setup

# Ask for explicit HA Version to pull
echo -n "Enter HomeAssistant version to use: "
read ha_v
export HA_VERSION=$ha_v

# Stopping the running compose
docker-compose down

# Pull image
echo "Pulling last image(s) for ${PWD}..."
docker-compose pull

# Stop the running compose setup
echo "Stopping ${PWD} runtime"
docker-compose down

# Start the new compose setup
echo "Starting ${PWD} runtime"
docker-compose up -d

# Ask if docker system prune should be performed
echo "Do you wish to run docker system cleanup?"
select yn in "Yes" "No"; do 
	case $yn in
		Yes ) docker system prune -f; break;;
		No ) break;;
	esac
done

echo "Upgrade done :)"

