FROM node:18-alpine

WORKDIR /app

COPY index.html .
COPY server.js .

EXPOSE 6060

ENV DISPLAY_TEXT="Welcome to Hack Club!"

CMD ["node", "server.js"]
