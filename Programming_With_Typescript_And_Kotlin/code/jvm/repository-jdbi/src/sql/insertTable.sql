START TRANSACTION;

DO $$
    BEGIN

    INSERT INTO REGISTRATION_INVITES (code)
    VALUES('invite1');

    INSERT INTO USERS (name, email, password_validation)
    VALUES
        ('user1', 'user1@example.com', 'XohImNooBHFR0OVvjcYpJ3NgPQ1qq73WKhHvch0VQtg=');

    INSERT INTO CHANNELS (name, owner_id, type, invite_code_with_write, invite_code_read_only)
    VALUES
        ('channel1', 1, 'PUBLIC', null, null);

    INSERT INTO PARTICIPANTS (user_id, channel_id, type)
    VALUES
        (1, 1, 'OWNER');

    INSERT INTO MESSAGES (text, author_id, time)
    VALUES
        ('message1', 1, '2020-01-01 00:00:00'),
        ('message4', 1, '2020-01-01 00:00:03'),
        ('message7', 1, '2020-01-01 00:00:06');

    END;
$$ LANGUAGE plpgsql;
COMMIT;