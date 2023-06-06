To deploy the application:

- Modify the hosts under the remote group inside the inventory file as needed
- Change the host from local to remote under Deploy App and DB if needed to either deploy locally or remotely
- In the directory of the playbook run the following command as ansible user: `ansible-playbook -i inventory.yaml --ask-become-pass --ask-pass ansible-playbook.yml` This command will prompt for ansible user password and sudo password.
- This playbook deploys a dotnet application image pulled from a private registry and a postgres database and establishes a connection between the two
- The needed variables should be modified in roles/deploy_app/defaults/main.yml and roles/deploy_app/vars/main.yml