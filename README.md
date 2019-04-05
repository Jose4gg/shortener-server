# SHORTENER

> This project is live on: https://guarded-badlands-25914.herokuapp.com

## Requirements

- Ruby 2.5.3, bundler, and PostgreSQL installed on the machine.
- bundle install to download the required dependencies.
- Run the rails db migration on the console with `rake db:migrate`
- An .env file is needed containing the key PUBLIC_HOST. The value for this key should be the baseURL where the server is running, ex: http://localhost:3000

## How the shortener works

- First we need to assing a personal ID for each new url that the user inserts.
- This information is stored in the Website model with an auto increment primary key.
- This ID is useful and can be used to identify the objects but because of the nature of the numbers system, this ID can grow very fast limiting the ability of the API.
- So, my solution for this, based on a research of how other companies do this, it is basically that we need to create our own base(n) numeric system just like the hexadecimal world, where we can represent numbers with letters.
- This new numeric system has a limit. We cannot just simply add all the characters that we want to th system because of the nature of the URL syntax. Charaters like \ or ) will always get translated to their UTF-8 code (%21, %2E), making the URL look bad and limiting the shorting mechanism.
- So I created a Shorteable Module that can be included on all classes, and it basically provides the developer the ability of select from which field it want to create the short_id version.
- This Shorteable module contains the functionality to generate the short_id and get the id based on the short version.
- The algorithm will take a simple number (1, 2, 500), and generate a shorten version with a base(62) numeric system, where numbers don't go from 1 to 9, they go from a..z to A..z to 0..9.

## Generate fake data

- If you want to generate fake data to test you can run `rake data:create_random_url`
