FROM node:lts-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine

# Xóa các file log mặc định hoặc liên kết cũ
RUN rm -f /var/log/nginx/access.log /var/log/nginx/error.log

# Định hướng lại log về /dev/null
RUN ln -sf /dev/null /var/log/nginx/access.log \
    && ln -sf /dev/null /var/log/nginx/error.log

# Copy code tĩnh đã build vào thư mục của Nginx
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
