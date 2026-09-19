FROM nginx:alpine

# Xóa các file log mặc định hoặc liên kết cũ
RUN rm -f /var/log/nginx/access.log /var/log/nginx/error.log[cite: 2]

# Định hướng lại log về /dev/null[cite: 2]
RUN ln -sf /dev/null /var/log/nginx/access.log \
    && ln -sf /dev/null /var/log/nginx/error.log[cite: 2]

# Copy trực tiếp thư mục build tĩnh đã được tạo ra từ GitHub Actions
COPY build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"][cite: 2]