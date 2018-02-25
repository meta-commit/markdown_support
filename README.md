# meta_commit markdown support
[![Build Status](https://travis-ci.org/meta-commit/markdown_support.svg?branch=master)](https://travis-ci.org/meta-commit/markdown_support)

This gem adds markdown language support to [meta_commit](https://github.com/usernam3/meta_commit) commands

## Installation

Install gem :

    $ gem install meta_commit_markdown_support

## Usage

To add markdown markup language support to meta_commit runner for specific repository you need to :

-   edit meta_commit.yml file of repo
-   add `markdown_support` to list of extensions

Now meta_commit knows that repository requires markdown support and will load this gem
