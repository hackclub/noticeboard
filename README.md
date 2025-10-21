# Hack Club Downtime Notice

Simple page to notify users during downtime.

## Coolify Deployment

1. Create a new service in Coolify
2. Point to this repository
3. Set the environment variable:
   - `DISPLAY_TEXT` - Your message (supports Markdown)
4. Set port to `6060`

Example:
```
DISPLAY_TEXT="We're currently experiencing downtime.\n\nCheck [status page](https://status.example.com) for updates."
```

## Local Testing

```bash
docker build -t notice .
docker run -p 6060:6060 -e DISPLAY_TEXT="Down for maintenance" notice
```
