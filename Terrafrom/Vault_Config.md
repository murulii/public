
# Install Vault using below link

```
https://developer.hashicorp.com/vault/install

```


## Start Vault.

To start Vault, you can use the following command:

```
vault server -dev -dev-listen-address="0.0.0.0:8200"
```

## Create Secrets in Vault

Go to Secretes eNGINE Enable KV--> inside kv create project1 folder-->ther add user aws keys and region

## Configure Terraform to read the secret from Vault.

Detailed steps to enable and configure AppRole authentication in HashiCorp Vault:

1. **Enable AppRole Authentication**: (its like IAM role)

To enable the AppRole authentication method in Vault, you need to use the Vault CLI or the Vault HTTP API.

**Using Vault CLI**:

Run the following command to enable the AppRole authentication method:

```bash
vault auth enable approle    (enable app role to authenticate from remote source)
```

This command tells Vault to enable the AppRole authentication method.

2. **Create an AppRole**:

We need to create policy first,

```
vault policy write terraform - <<EOF
path "*" {
  capabilities = ["list", "read"]
}

path "secrets/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "kv/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}


path "secret/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "auth/token/create" {
capabilities = ["create", "read", "update", "list"]
}
EOF
```

Now you'll need to create an AppRole with appropriate policies and configure its authentication settings. Here are the steps to create an AppRole:

**a. Create the AppRole**: (this will genrate keys and gives expriration time)

```bash
vault write auth/approle/role/terraform \
    secret_id_ttl=10m \
    token_num_uses=10 \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40 \
    token_policies=terraform
```

3. **Generate Role ID and Secret ID**:

After creating the AppRole, you need to generate a Role ID and Secret ID pair. The Role ID is a static identifier, while the Secret ID is a dynamic credential.

**a. Generate Role ID**:

You can retrieve the Role ID using the Vault CLI:

```bash
vault read auth/approle/role/terraform/role-id
```

Save the Role ID for use in your Terraform configuration.

**b. Generate Secret ID**:

To generate a Secret ID, you can use the following command:

```bash
vault write -f auth/approle/role/terraform/secret-id
   ```

This command generates a Secret ID and provides it in the response. Save the Secret ID securely, as it will be used for Terraform authentication.



# How to Use in Main.tf

```
provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address = "http://22.22.1.2:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "add your role id"
      secret_id = "add ur secret id"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "secret" // change it according to your mount
  name  = "test-secret" // change it according to your secret
}

resource "aws_instance" "my_instance" {
  region = data.vault_kv_secret_v2.example.data["region"]
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name = "test"
    Secret = data.vault_kv_secret_v2.example.data["foo"]
  }
}



```
