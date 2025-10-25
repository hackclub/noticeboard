#!/bin/sh
set -e

DISPLAY_TEXT="${DISPLAY_TEXT:-Welcome to Hack Club!}"

# Debug: Show input
echo "=== Input DISPLAY_TEXT ==="
echo "$DISPLAY_TEXT"
echo "==========================="

# Convert escape sequences to actual characters for markdown processing
# Coolify double-escapes, so we need to process twice
# First, use printf to handle the first level of escaping
STEP1=$(printf '%b' "$DISPLAY_TEXT")

# Second, use printf again to convert \n to actual newlines and unescape quotes
# Also handle \r\n (Windows line endings)
STEP2=$(printf '%b' "$STEP1" | sed 's/\\r//g')

# Remove the backslash before ! to fix image syntax, and unescape apostrophes
PROCESSED_TEXT=$(echo "$STEP2" | sed "s/\\\\'/'/g" | sed 's/\\!/!/g')

# Render markdown to HTML using discount package (provides the 'markdown' command)
RENDERED_HTML=$(printf '%s' "$PROCESSED_TEXT" | markdown)

# Debug: Show final output
echo "=== Final HTML Output ==="
echo "$RENDERED_HTML"
echo "========================="

# Generate static HTML with rendered content
cat > /app/index.html << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hack Club Notice</title>
    <link rel="icon" type="image/png" href="https://assets.hackclub.com/icon-square.png">
    <link href="https://fonts.googleapis.com/css2?family=Phantom+Sans:wght@400;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }


        body {
            font-family: 'Phantom Sans', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: #fafbfc;
            min-height: 100vh;
            color: #252429;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }


        .logo {
            position: absolute;
            top: 0;
            left: 1.5rem;
            width: 180px;
            height: auto;
            z-index: 10;
            opacity: 0.95;
        }


        .container {
            width: 100%;
            max-width: 650px;
            padding: 2rem;
        }


        .display-text {
            font-size: 1.375rem;
            font-weight: 500;
            line-height: 1.7;
            text-align: left;
            color: #252429;
        }


        .display-text a {
            color: #ec3750;
            text-decoration: none;
            border-bottom: 2px solid #ec3750;
            transition: all 0.2s ease;
            font-weight: 600;
        }


        .display-text a:hover {
            color: #ff8c37;
            border-bottom-color: #ff8c37;
        }


        .display-text img {
            max-width: 100%;
            height: auto;
            margin: 2rem 0;
            border-radius: 8px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.06);
            display: block;
        }


        .display-text p {
            margin: 1.75rem 0;
        }


        .display-text p:first-child {
            margin-top: 0;
        }


        .display-text p:last-child {
            margin-bottom: 0;
        }


        .display-text strong {
            color: #ec3750;
            font-weight: 700;
        }


        .display-text code {
            background: #f0f0f1;
            padding: 0.2em 0.5em;
            border-radius: 4px;
            font-size: 0.9em;
            font-family: 'SF Mono', 'Monaco', 'Courier New', monospace;
            color: #252429;
        }


        @media (max-width: 768px) {
            .logo {
                width: 130px;
                top: 0;
                left: 1rem;
            }


            .display-text {
                font-size: 1.15rem;
            }


            .container {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <img class="logo" src="https://assets.hackclub.com/flag-orpheus-top.svg" alt="Hack Club">
    <div class="container">
        <div class="display-text">
$RENDERED_HTML
        </div>
    </div>
</body>
</html>
EOF

echo "Generated static HTML with display text"
