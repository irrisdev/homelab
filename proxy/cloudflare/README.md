# Cloudflare DDNS Script

This script updates a Cloudflare DNS record with the current public IP of your machine using the Cloudflare API.

## Prerequisites

- Cloudflare account and API key.

- Zone ID and DNS record ID for the domain you want to update.

- `.env` file with the following variables:
  ```bash
  CL_ZONE_ID="your_zone_id"
  CL_DNS_ID="your_dns_id"
  CL_EMAIL="your_email"
  CL_API="your_api_key"
  CL_DNS="your_domain_name"

## Usage

1. Clone the repository and navigate to the directory:
   ```bash
   git clone https://github.com/irridev/server-setup
   cd cloudflare-ddns
   ```

2. Create a .env file with your Cloudlfare credentials.
   
3. Make the script executable:
   ```bash
   chmod +x ddns.sh
   ```

4. Run the script
   ```bash
   ./ddns.sh
   ```

## Automate with Cron

To run the script every 5 minutes and log output to a file:

1. Edit the crontab:
   ```bash
   crontab -e
   ```

2. Add the following line after editing `clone` to your local clone:
   ```bash
   */5 * * * * <clone>/cloudflare-ddns/ddns.sh > <clone>/cloudflare-ddns/ddns.log 2>&1