# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |

### Association

- has_many :items
- has_many :transactions
- has_one :identity_verification

## identity_verifications テーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| last_name            | string     | null: false                    |
| first_name           | string     | null: false                    |
| last_name_reading    | string     | null: false                    |
| first_name_reading   | string     | null: false                    |
| birth_date           | date       | null: false                    |
| user                 | references | null: false, foreign_key: true |

### Association

- belongs_to :user


## items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| item_name        | text       | null: false                    |
| item_description | text       | null: false                    |
| category         | integer    | null: false                    |
| condition        | integer    | null: false                    |
| price            | string     | null: false                    |
| sold_status      | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- has_one :shipping
- has_one :transaction

## shippings テーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| shipping_cost_burden  | integer    | null: false                    |
| region                | integer    | null: false                    |
| days_until_shipment   | integer    | null: false                    |
| item                  | references | null: false, foreign_key: true |

### Association

- belongs_to :item

## transactions テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| item     | references | null: false, foreign_key: true |
| user     | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item


## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture    | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| transaction   | references | null: false, foreign_key: true |

### Association

- belongs_to :transaction

