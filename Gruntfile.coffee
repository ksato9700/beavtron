module.exports = (grunt)->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    watch:
      files: ['app.coffee', 'routes/*.coffee']
      tasks: ['newer:coffee']
    coffee:
      compile:
        files: [
          expand: true
          cwd: './'
          src: ['app.coffee', 'routes/**/*.coffee']
          dest: './'
          ext: '.js'
        ]

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-newer'

  grunt.registerTask 'default', ['watch']
  return
