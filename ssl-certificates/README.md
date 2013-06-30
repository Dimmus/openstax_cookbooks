## Description

Installs SSL certificates.

## USAGE

In the Node JSON, define an ````ssl_certificates```` block as follows:


    "ssl_certificates": {
      "basename_1": {
        "extension_a": "file content here",
        "extension_b": "file content here"
      },
      "basename_2": {
        "extension_a": "file content here",
        "extension_b": "file content here"
      }
    }


And then run the `ssl_certificates::install` recipe.

In the directory specified by `node["ssl_certificates"]["options"]["path"]`, this will create two files: `basename_1.extension_a` and `basename_1.extension_b` with the respective values for `"file content here"`.

A more realistic example might look like:

    "ssl_certificates": {
      "my_db_as_a_service": {
        "crt": "file content here",
        "ca_bundle": "file content here"
      },
    }
