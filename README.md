# KIDS Dashboard

A beautiful, interactive dashboard for kids featuring daily schedules, weather, chores, and more.

## Features

- **Daily Calendar Events**: Displays today's events from Google Calendar
- **Weekly View**: Shows the week ahead with event icons
- **Weather Display**: Current weather conditions with kid-friendly descriptions
- **Season & Month**: Shows current season and month with emojis
- **Christmas Countdown**: Days until Christmas
- **Chores Tracker**: Interactive chore list with progress tracking and celebrations
- **Responsive Design**: Modern, colorful UI optimized for kiosk displays

## Setup

1. Clone this repository
2. Create a `.env` file in the root directory with the following variables:

```env
CALENDAR_ID=your-google-calendar-id
API_KEY=your-google-api-key
SHEET_CSV_URL_ORIGINAL=your-google-sheets-csv-url
LATITUDE=your-latitude
LONGITUDE=your-longitude
KID1_NAME=Jack
KID2_NAME=Autumn
KIDS_NAMES=Jack & Autumn
```

3. For development, you can edit `kid-dash.html` directly (the placeholders will need to be replaced manually)

## Deployment

To create a packaged HTML file ready for deployment with all environment variables embedded:

```bash
./package.sh [output-file]
```

This script:
- Reads variables from `.env`
- Replaces placeholders in `kid-dash.html`
- Outputs a ready-to-deploy HTML file (default: `kid-dash-packaged.html`)

Example:
```bash
./package.sh
# Creates kid-dash-packaged.html

./package.sh deployed.html
# Creates deployed.html
```

The packaged file contains all necessary configuration and can be deployed directly to a web server.

## Screenshot

![Dashboard Screenshot](screenshot.png)

*Note: Add a screenshot of your dashboard here*

## Requirements

- Modern web browser with JavaScript enabled
- Internet connection for:
  - Google Calendar API
  - Google Sheets (for chores)
  - Open-Meteo weather API

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

