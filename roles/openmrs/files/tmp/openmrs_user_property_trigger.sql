-- Sql to create a trigger in mysql OpenMRS database to prevent admin and other user accounts from locking
-- By resetting the property_value for login attempts to zero every its increased.

-- Create a temp user_property table to hold the trigger
CREATE TABLE IF NOT EXISTS user_property (
  user_id int(11) NOT NULL DEFAULT '0',
  property varchar(100) NOT NULL DEFAULT '',
  property_value varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (user_id,property)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create the trigger
DROP TRIGGER IF EXISTS user_property_before_update;
DELIMITER $$
CREATE TRIGGER user_property_before_update BEFORE UPDATE ON user_property
  FOR EACH ROW
  BEGIN
    IF (select property_value from user_property where user_id = 1 and (property ='loginAttempts' OR property ='lockoutTimestamp')) THEN
      SET NEW.property_value = 0;
    END IF;
  END $$
DELIMITER ;
