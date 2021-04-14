# Rental box

testtest3

# URL
https://rental-box.work/

# 使用技術
- Ruby 2.5.7
- Ruby on Rails 5.2.5
- MySQL 5.7
- Nginx
- Puma
- AWS
  - VPC
  - EC2
  - RDS
  - Route53
- Docker/Docker-compose
- CircleCi CI/CD
- Capistrano3
- RSpec

# AWS構成図
![インフラ構成図 (1)](https://user-images.githubusercontent.com/65978449/114654892-13b6d780-9d26-11eb-9ac1-b188d16d340c.jpg)

## CircleCi CI/CD
- Githubへのpush時に、RspecとRubocopが自動で実行されます。
- masterブランチへのpushでは、RspecとRubocopが成功した場合、EC2への自動デプロイが実行されます

# 機能一覧

# テスト