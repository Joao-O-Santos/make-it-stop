<!-- 1 MENU_ENTRY=Tutorial -->
# Tutorial

Here you can find an introductory tutorial on how to use `make it_stop`
to make your static website.


## Checkout `config.mk`

Take a look at the `config.mk` and see if you want to change any
defaults.


## Write Your Pages

To use `make it_stop` write your websites pages' in `PAGES_DIR`
(which is `pages/` by default; see `config.mk`). **To include a link to
a page in the top menu bar add a comment formatted as `<!--` `X
MENU_ENTRY=LINK TEXT HERE` `-->` somewhere in the page, where is the
entry's position in the menu, if X is missing all entries are sorted by
`LINK TEXT HERE`.**


## Write HTML/CSS

Write whatever `HTML` and `CSS` code you may need in `TEMPLATES_DIR`
(which is `templates/` by default, see `config.mk`)

- `HTML` to appear **BEFORE** each pages' menu goes in
  `TEMPLATES_DIR/header.html`.

- `HTML` to appear **AFTER** each pages' menu but **BEFORE** the main
  text in `TEMPLATES_DIR/after_menu.html`.

- `HTML` to after the main text goes in `TEMPLATES_DIR/footer.html`.

- Style your webpage by writing your styles in
  `TEMPLATES_DIR/styles.css`.


## Run `make it_stop`

If you completed the above steps you should have enough to build your
website. To build your website you simply need to run `make it_stop`
from the directory where the `Makefile` lives.

*Note: Running `make` instead of `make it_stop` works just as well but
where's the fun in that.*


## Preview

You should now have your web pages ready to preview in `WEB_DIR`, you
simply need to point your browser there and view them (e.g., `firefox
public/index.html `).

If you make changes to the page or templates you can rerun `make
it_stop` and refresh the page (i.e., you don't need to close the browser
and open it again).


## Iterate Until Ready to Deploy

You can iterate over the previous steps until you're happy with your
website and are ready to deploy it.


## Deploy

To deploy your website you need to somehow get all the files in
`WEB_DIR` to the web server that is hosting your website.

There are several user and budget friendly options to host static
websites.

Below we explain how to host your webpages for free using GitLab Pages
but you may check a tutorial for your hosting solution/provider (e.g.,
Netlify).


### GitLab Pages

If you wish to host it as a GitLab Pages go to your GitLab repo and
ensure you have the GitLab Pages feature enabled.

If you wish to host your static websites using the GitLab Pages service
you can do so by using the simple `.gitlab-ci.yml` included in the
`make it_stop` [repo](https://gitlab.com/joao-o-santos/make-it-stop).

<pre class="code-block">
image: alpine

pages:
    stage: deploy
    script:
        - apk update
        - apk add make markdown
        - make
    artifacts:
        paths:
            - public
</pre>

In case you want your website to be publicly accessible set your
GitLab project's visibility to public. **WARNING: this will make all the
files you committed to your `git` repo available online through the
GitLab repo.** *Note: you can work on pages and files you don't want to
make public by putting them in `wip/`, which is `.gitignore`d by
default, just take caution not to `git add -f` those files.*
