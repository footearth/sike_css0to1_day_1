{log} = console
_ = require 'lodash'
gulp = require 'gulp'
{
  join
  basename
  extname
} = require 'path'

gulpFilter = require 'gulp-filter'

libs_obj =
  base: 'bower_components'
  files:
    'normalize.css': 'normalize.css'

getlibfiles = (libs) ->
  {base} = libs
  {files} = libs
  libsArr = []

  for libname, libfiles of files
    if _.isArray libfiles
      for libfile in libfiles
        libsArr.push "#{base}/#{libname}/#{libfile}"
    else if _.isString libfiles
      libsArr.push "#{base}/#{libname}/#{libfiles}"
    else return

  libsArr

module.exports = (callback) ->

  jsFilter = gulpFilter ['**/*.js']
  cssFilter = gulpFilter ['**/*.css']
  fontsFilter = gulpFilter [
    '**/*.eot'
    '**/*.svg'
    '**/*.ttf'
    '**/*.woff'
    '**/*.woff2'
  ]

  gulp.src getlibfiles libs_obj

  # js
  .pipe jsFilter
  .pipe gulp.dest 'build/scripts/libs'
  .pipe jsFilter.restore()

  # css
  .pipe cssFilter
  .pipe gulp.dest 'build/styles/libs'
  .pipe cssFilter.restore()

  # fonts
  .pipe fontsFilter
  .pipe gulp.dest 'build/styles/fonts'
  .pipe fontsFilter.restore()

  callback()
