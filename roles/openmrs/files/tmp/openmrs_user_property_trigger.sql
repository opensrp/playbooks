-- Sql to create a trigger in mysql OpenMRS database to prevent admin and other user accounts from locking
-- By resetting the property_value for login attempts to zero every its increased.
DELIMITER $$
CREATE TRIGGER user_property_before_update BEFORE UPDATE ON user_property
  FOR EACH ROW
  BEGIN
    IF (select property_value from user_property where user_id = 1 and (property ='loginAttempts' OR property ='lockoutTimestamp')) THEN
      SET NEW.property_value = 0;
    END IF;
  END $$
DELIMITER ;
