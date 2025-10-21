# Hack Club Downtime Notice

Simple page to notify users during downtime.

## Coolify Deployment

1. Create a new service in Coolify
2. Point to this repository
3. Set the environment variable:
   - `DISPLAY_TEXT` - Your message (supports Markdown)
4. Set port to `80`

**Note:** Changing `DISPLAY_TEXT` only requires a container restart, not a rebuild. The HTML is generated at container startup.

Example:
```
DISPLAY_TEXT="We're currently experiencing downtime.\n\nCheck [status page](https://status.example.com) for updates."
```

## Example:

<img width="1355" height="984" alt="Screenshot 2025-10-20 at 9 13 26 PM" src="https://github.com/user-attachments/assets/7d8af4d8-c1a4-44b1-acbc-6d211e53047f" />

```
DISPLAY_TEXT=Hackatime is currently moving to a new, faster server\n\nIt'll take about 1 hour. Don't worry - even if Hackatime in your editor is giving you errors, all of your heartbeats are saved locally and will be uploaded when Hackatime is back online. No time will be lost.\n\nWish Hackatime a good move! It'll be back in about 1 hour.\n\n\![](https://miro.medium.com/v2/resize:fit:1000/format:webp/0*l3ty80Q-AIGrVpLH.gif)
```


## Local Testing

```bash
docker build -t notice .
docker run -p 8080:80 -e DISPLAY_TEXT="Down for maintenance" notice
```

Visit http://localhost:8080 to see your notice.
