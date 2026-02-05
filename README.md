# Stripe API PostgreSQL Extension

> [!NOTE]
> The Stripe API PostgreSQL Extension is currently **experimental** and we're excited for you to experiment with it!
>
> This extension has not yet been exhaustively tested in production environments and may be missing some features you'd expect in a stable release. As we continue development, there may be breaking changes that require updates to your code.
>
> **We'd love your feedback!** Please share any suggestions, bug reports, feature requests, or general thoughts by [filing an issue](https://www.github.com/stainless-sdks/stripe-minimal-sql/issues/new).

The Stripe API PostgreSQL Extension provides convenient access to the [Stripe REST API](https://stripe.com) from PostgreSQL.

It is generated with [Stainless](https://www.stainless.com/).

The REST API documentation can be found on [stripe.com](https://stripe.com).

## Installation

Clone the repository:

```sh
git clone git@github.com:stainless-sdks/stripe-minimal-sql.git
cd stripe-minimal-sql
```

Install the extension:

```sh
make install
```

And load it into the relevant database:

```sql
CREATE EXTENSION IF NOT EXISTS plpython3u; -- Dependency
CREATE EXTENSION stripe_minimal;
```

### Troubleshooting

If you encounter an error such as:

```
make: pg_config: Command not found
```

Then ensure you have `pg_config` installed and in your `PATH`. If necessary, tell `make` where to find it:

```sh
PG_CONFIG=/path/to/pg_config make install
```

To install the extension in a custom prefix on PostgreSQL 18 or later, pass the `prefix` argument:

```sh
make install prefix=/usr/local/extras
```

You must also ensure that the prefix is included in the following [`postgresql.conf` parameters](https://www.postgresql.org/docs/current/config-setting.html#CONFIG-SETTING-CONFIGURATION-FILE):

```conf
extension_control_path = '/usr/local/extras/postgresql/share:$system'
dynamic_library_path   = '/usr/local/extras/postgresql/lib:$libdir'
```

## Requirements

This extension requires:

- PostgreSQL 14 or higher
- [PL/Python](https://www.postgresql.org/docs/current/plpython.html)
- Python 3.9 or higher

## Usage

```sql
SELECT *
FROM stripe_minimal_account.retrieve();
```

## Client configuration

Configure the client by setting configuration parameters at the database level:

```sql
ALTER DATABASE my_database SET stripe_minimal.secret_key = 'My API Key';
```

See this table for the available configuration parameters:

| Parameter                   | Required | Default value               |
| --------------------------- | -------- | --------------------------- |
| `stripe_minimal.secret_key` | false    | -                           |
| `stripe_minimal.base_url`   | false    | `'https://api.stripe.com/'` |

## Requests and responses

To send a request to the Stripe API, call the relevant SQL function with values corresponding to the parameter types and `SELECT` the columns you need from the returned rows.

To construct [composite type](https://www.postgresql.org/docs/current/rowtypes.html) parameters, use the parameter type's provided `make_*` function. For example, `stripe_minimal_coupon.applies_to` may be constructed like so:

```sql
stripe_minimal_coupon.make_applies_to(products := ARRAY['string'])
```

## Semantic versioning

This package generally follows [SemVer](https://semver.org/spec/v2.0.0.html) conventions, though certain backwards-incompatible changes may be released as minor versions:

1. Changes to library internals which are technically public but not intended or documented for external use. _(Please open a GitHub issue to let us know if you are relying on such internals.)_
2. Changes that we do not expect to impact the vast majority of users in practice.

We take backwards-compatibility seriously and work hard to ensure you can rely on a smooth upgrade experience.

We are keen for your feedback; please open an [issue](https://www.github.com/stainless-sdks/stripe-minimal-sql/issues) with questions, bugs, or suggestions.
