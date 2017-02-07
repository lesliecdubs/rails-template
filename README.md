## Dataminr

Uses canvas-rails-template.

Heroku Setup
```
git remote -v
git remote rename heroku production
git remote add staging https://git.heroku.com/HEROKU-APP-NAME.git
```

```
heroku buildpacks:add --index 1 heroku/nodejs
heroku buildpacks:add heroku/ruby
```
