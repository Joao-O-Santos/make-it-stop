![Build Status](https://gitlab.com/joao-o-santos/markdown-html/badges/main/build.svg)

---

Example plain markdown with custom html and css (relying on GNU Make)
website using GitLab Pages.

Learn more about GitLab Pages at https://pages.gitlab.io and the official
documentation https://docs.gitlab.com/ce/user/project/pages/.

---

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [GitLab CI](#gitlab-ci)
- [Building locally](#building-locally)
- [GitLab User or Group Pages](#gitlab-user-or-group-pages)
- [Did you fork this project?](#did-you-fork-this-project)
- [Troubleshooting](#troubleshooting)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Description

This project aims at developing infrastructure for generating simple
pages (and one day blogs as well) from plain markdown files, coupled with
some basic `html` and `css`, effectively using `GNU Make` as the static
website generator.


## GitLab CI

This project's static Pages are built by [GitLab CI][ci], following the steps
defined in [`.gitlab-ci.yml`](.gitlab-ci.yml):

```
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
```

## Building locally

To work locally with this project, you'll have to follow the steps below:

1. Fork, clone or download this project
2. Install [GNU Make](https://www.gnu.org/software/make/) and a markdown
   renderer (e.g.,
   [discount](https://www.pell.portland.or.us/~orc/Code/discount/))
3. Write each page in markdown in `pages/` (e.g., `pages/example.md`).
4. Generate the website: `make`
5. Preview your project: use your browser to open `public/index.html`

## GitLab User or Group Pages

To use this project as your user/group website, you will need one additional
step: just rename your project to `namespace.gitlab.io`, where `namespace` is
your `username` or `groupname`. This can be done by navigating to your
project's **Settings**.

Read more about [user/group Pages][userpages] and [project Pages][projpages].

## Did you fork this project?

If you forked this project for your own use, please go to your project's
**Settings** and remove the forking relationship, which won't be necessary
unless you want to contribute back to the upstream project.

[ci]: https://about.gitlab.com/gitlab-ci/
[markdown-html]: http://gitlab.com/joao-o-santos/markdown-html
[install]: http://link-to-install-page
[documentation]: http://link-to-main-documentation-page
[userpages]: https://docs.gitlab.com/ce/user/project/pages/introduction.html#user-or-group-pages
[projpages]: https://docs.gitlab.com/ce/user/project/pages/introduction.html#project-pages

----
