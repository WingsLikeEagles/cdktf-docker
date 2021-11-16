# cdktf-docker
Docker implmentation of CDKTF for Terraforming  

Initial credit goes to https://www.reddit.com/user/SnooPears9582/  
From his post at https://www.reddit.com/r/Terraform/comments/qqqe8r/executing_cdktf_from_within_a_container/  


# Build the container  
This requires a file in the current directory named cdktf.json and the Dockerfile both from this repo.  
`docker build -t cdktf-docker .`  

# Run the container  
`docker run --rm --name cdktf -i cdktf-docker:latest cdktf convert --language python`  

# Pip something in to the container  
`cat my_super_awesome_stuff.tf | docker run --rm --name cdktf-docker -i cdktf-docker:latest cdktf convert --language python`  
  
  
