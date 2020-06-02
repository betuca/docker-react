FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
CMD gunicorn --bind 0.0.0.0:$PORT wsgi
COPY --from=builder /app/build /usr/share/nginx/html