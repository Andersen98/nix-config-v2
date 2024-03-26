{config,...}:{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hannah = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; #Enable ‘sudo’ for the user.
  };
  
} 
