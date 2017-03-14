# Futurium ISA Starterkit

```
  ███████╗██╗   ██╗████████╗██╗   ██╗██████╗ ██╗██╗   ██╗███╗   ███╗    ██╗███████╗ █████╗
  ██╔════╝██║   ██║╚══██╔══╝██║   ██║██╔══██╗██║██║   ██║████╗ ████║    ██║██╔════╝██╔══██╗
  █████╗  ██║   ██║   ██║   ██║   ██║██████╔╝██║██║   ██║██╔████╔██║    ██║███████╗███████║
  ██╔══╝  ██║   ██║   ██║   ██║   ██║██╔══██╗██║██║   ██║██║╚██╔╝██║    ██║╚════██║██╔══██║
  ██║     ╚██████╔╝   ██║   ╚██████╔╝██║  ██║██║╚██████╔╝██║ ╚═╝ ██║    ██║███████║██║  ██║
  ╚═╝      ╚═════╝    ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝     ╚═╝    ╚═╝╚══════╝╚═╝  ╚═╝
```

This is a starting point for creating new instances of the Futurium ISA project.

## Features

- Easily test your code.
- Integrated support for Behat and PHP CodeSniffer.
- QA automation tools to provide static code checks.
- Built-in support for Continuous Integration using ContinuousPHP.
- Build your website in an automated way to get your entire team up and running
  fast!

## Repository structure

### 1. Project configuration

The configuration of the project is managed in 3 `build.properties` files:

1.  `build.properties.dist`: This contains default configuration which is
    common for all Futurium projects. *This file should never be edited.*
2.  `build.properties`: This is the configuration for your project. In here you
    can override the default configuration with settings that are more suitable
    for your project. Some typical settings would be the site name, the install
    profile to use and the modules/features to enable after installation.
3.  `build.properties.local`: This contains configuration which is unique for
    the local development environment. In here you would place things like your
    database credentials and the development modules you would like to install.
    *This file should never be committed.*

### 2. Project code

* Your custom modules, themes and custom PHP code go in the `lib/` folder. The
  contents of this folder get symlinked into the Drupal website at `sites/all/`.
* Any contrib modules, themes, libraries and patches you use should be put in
  the make file `resources/site.make`. Whenever the site is built these will be
  downloaded and copied into the Drupal website. By default we provide an example
  file in `resources/site.make.example`. Feel free to copy or rename this file
  to `resources/site.make`. This make file will be included in `build-dev`
  and `build-dist` by default.
* If you have any custom Composer dependencies, declare them in
  `resources/composer.json` and `resources/composer.lock`.
* If you require custom build steps for your subsite, you are free to use the
  `resources/build.custom.xml` phing target. This target is included by default
   in build-dev & build-dist targets.

### 3. Drupal root

The Drupal site will be placed in the `platform/` folder when it is built. Point
your webserver here. This is also where you would execute your Drush commands.
Your custom modules are symlinked from `platform/sites/all/modules/custom/` to
`lib/modules/` so you can work in either location, whichever you find the most
comfortable.

### 4. Behat tests

All Behat related files are located in the `tests/` folder.

* `tests/behat.yml`: The Behat configuration file. This file is regenerated
  automatically when the project is built and should never be edited or
   committed.
* `tests/behat.yml.dist`: The template that is used for generating `behat.yml`.
  If you need to tweak the configuration of Behat then this is the place to do
  that.
* `tests/features/`: Put your Behat test scenarios here.
* `tests/src/Context/`: The home of custom Context classes.
* You can also put test scenarios onto your features/modules folders.

### 5. Other files and folders

* `bin/`: Contains command line executables for the various tools we use such as
  Behat, Drush, Phing, PHP CodeSniffer etc.
* `build/`: Will contain the build intended for deployment to production. Use
  the `build-dist` Phing target to build it.
* `src/`: Custom PHP code for the build system, such as project specific Phing
  tasks.
* `tmp/`: A temporary folder where the profile is downloaded and built during
  the build process.
* `vendor/`: Composer dependencies and autoloader.



### 1. Download the project

Our project is called `cnect-webdev/futurium-starterkit` and is hosted on our
Github:

```
$ git clone https://github.com/cnect-webdev/futurium-starterkit.git
$ cd futurium-starterkit
```

### 2. Install dependencies

The software packages that are needed to build the project are installed with
[Composer](https://getcomposer.org/). See the documentation for Composer for
more information on how to install and use it.

```
$ composer install
```

### 3. Create a build.properties.local file

This file contains the configuration which is unique to your local environment,
i.e. your development machine. In here you specify your database credentials,
your base URL, the administrator password etc.

Some other things that can be useful is to provide a list of your favourite
development modules to enable, and whether you want to see verbose output of
drush commands and tests. Another good trick is that you can try out your
project against different versions of the Multisite / NextEuropa platform, for
example you might want to check out if your code still runs fine on the latest
development version by setting `platform.package.reference` to `develop`.

> Because these settings are personal they should not be shared with the rest of
> the team. *Make sure you never commit this file!*

Example `build.properties.local` file:

        # Database settings.
        drupal.db.name = ec_futurium
        drupal.db.user =
        drupal.db.password =

        # Admin user.
        drupal.admin.username = admin
        drupal.admin.password = pass

        # The base URL to use in Behat tests.
        behat.base_url = http://futurium.local/

        # The location of the Composer executable.
        composer.bin = /usr/local/bin/composer


You can also specify development modules that only will be enabled locally
by listing them as below in the <b>drupal.development.modules</b> param.


        # Development / testing modules to enable.
        drupal.development.modules = devel devel_generate context_ui field_ui maillog simpletest views_ui


### 4. Build your local development environment

Now that our configuration is ready, we can build our project.

*
```
$ ./bin/phing build-dev
```

This will:

* Download the latest validated version of Drupal 7.x.
* Build the project into the `platform/` subfolder.
* Download the Futurium features and theme files into the `lib/` folder
* Symlink your custom modules and themes into the platform. This allows you to
  work inside the Drupal site, and still commit your files easily.


### 5. Install the site

* As an <b>external party</b> willing to use Futurium and store it on your your own repository, use:
```
$ ./bin/phing install
```

* As a developer <b>inside European Commission</b> use:
```
$ ./bin/phing install-dev
```

This will:

* Install the website with `drush site-install`.
* Enable the modules you specified in the `drupal.development.modules` property.

After a few minutes (from 7 to 20 min depending on the machine) this process should complete and the website should be up
and running!


### 6. Set up your webserver

The Drupal site will now be present in the `platform/` folder. Set up a
virtualhost in your favourite web server (Apache, Nginx, Lighttpd, ...) and
point its webroot to this folder.

If you intend to run Behat tests then you should put the base URL you assign to
your website in the `build.properies.local` file for the `behat.base_url`
property. See the example above.
