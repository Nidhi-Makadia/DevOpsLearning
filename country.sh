read -p "Enter country name: " country

# Format for URL
country_encoded=$(echo "$country" | sed 's/ /%20/g')

# Fetch country info using restcountries API
response=$(curl -s "https://restcountries.com/v3.1/name/$country_encoded?fullText=true")

# Check if response is valid
if echo "$response" | grep -q "capital"; then
  name=$(echo "$response" | jq -r '.[0].name.common')
  capital=$(echo "$response" | jq -r '.[0].capital[0]')
  region=$(echo "$response" | jq -r '.[0].region')
  subregion=$(echo "$response" | jq -r '.[0].subregion')


  echo ""
  echo "🌐 Country: $name"
  echo "🏙️ Capital: $capital"
  echo "🌎 Region: $region ($subregion)"

else
  echo ""
  echo "❌ Country '$country' not found or invalid input."
fi
