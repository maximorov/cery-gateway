FROM golang:1.22.5-alpine AS builder

USER root

ARG ID_GITHUB_LOG_SSH_PRIVATE_KEY

#INSTALL PACKAGES
RUN apk --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/community add \
    bash \
    ca-certificates \
    tzdata \
    git \
    openssh \
    gcc \
    build-base \
    libc-dev \
    && rm -rf /var/cache/apk/*
RUN mkdir /root/.ssh && \
    apk add --no-cache openssh git

RUN echo "${ID_GITHUB_LOG_SSH_PRIVATE_KEY}" > /root/.ssh/sdk && \
    chmod 0600 /root/.ssh/sdk

RUN echo -e "Host sdk.github.com\n\
    HostName github.com\n\
    IdentityFile /root/.ssh/sdk\n\
    IdentitiesOnly yes\n\
Host proto.github.com\n\
    HostName github.com\n\
    IdentityFile /root/.ssh/proto\n\
    IdentitiesOnly yes" > /root/.ssh/config

RUN ssh-keyscan github.com > /root/.ssh/known_hosts

RUN git config --global url."git@sdk.github.com:Cery-Tech/log".insteadOf \
    "https://github.com/Cery-Tech/log"

WORKDIR /go/src/github.com/Cery-Tech/cmr-backend/

RUN mkdir -p ~/.ssh && umask 0777 && echo "${ID_GITHUB_LOG_SSH_PRIVATE_KEY}" > ~/.ssh/id_rsa
RUN ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts
RUN git config --global url."git@github.com:".insteadOf "https://github.com/"

COPY /go.mod .
COPY /go.sum .

RUN export GOPRIVATE="github.com/Cery-Tech/log"
RUN go mod download -x

COPY / ./
RUN CGO_ENABLED=0 GOOS=linux go build -o ./build/server ./cmd/server/website/main.go

FROM alpine:latest

WORKDIR /root/

COPY /deployments/staging/entrypoint-staging.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

COPY --from=builder /go/src/github.com/Cery-Tech/cmr-backend/build/server ./
COPY --from=builder /go/src/github.com/Cery-Tech/cmr-backend/.env.default ./

EXPOSE 50051

ENTRYPOINT ["./entrypoint.sh"]
CMD ["./server"]

