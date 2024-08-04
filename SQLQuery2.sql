CREATE TABLE QR_code (
    qr_id INT IDENTITY(1,1) PRIMARY KEY,
    encryption_status TINYINT,
    plaintext VARCHAR(100),
    qr_image VARCHAR(70)
);


CREATE TABLE Claimant (
    claimant_id INT IDENTITY(1,1) PRIMARY KEY,
    claimant_name VARCHAR(45),
    claimant_email VARCHAR(45),
    claimant_class VARCHAR(45),
    claimant_student_id VARCHAR(45),
    QR_code_qr_id INT,
    INDEX fk_claimant_qr_code_idx (QR_code_qr_id ASC),
    CONSTRAINT fk_claimant_qr_code
        FOREIGN KEY (QR_code_qr_id)
        REFERENCES QR_code (qr_id)
);


CREATE TABLE Coupon_Type (
    coupon_type_id INT IDENTITY(1,1) PRIMARY KEY,
    coupon_type_name VARCHAR(255),
    coupon_number VARCHAR(45)
);


CREATE TABLE Coupon_Offer (
    coupon_offer_id INT IDENTITY(1,1) PRIMARY KEY,
    coupon_offer_name VARCHAR(255),
    coupon_number VARCHAR(45)
);



CREATE TABLE Coupon_Item (
    coupon_item_id INT IDENTITY(1,1) PRIMARY KEY,
    item_description VARCHAR(255),
    coupon_id INT,
    INDEX fk_coupon_item_coupon_idx (coupon_id ASC),
    );




CREATE TABLE Campaign (
    campaign_id INT IDENTITY(1,1) PRIMARY KEY,
    campaign_name VARCHAR(45),
    campaign_description VARCHAR(45),
    cam_start_date DATE,
    cam_end_date DATE,
    budget DECIMAL(10,2),
    Coupon_coupon_id INT,
    Claimant_claimant_id INT,
    Claimant_QR_code_qr_id INT,
    INDEX fk_campaign_coupon_idx (Coupon_coupon_id ASC),
    INDEX fk_campaign_claimant_idx (Claimant_claimant_id ASC),
    INDEX fk_campaign_qr_code_idx (Claimant_QR_code_qr_id ASC),
       CONSTRAINT fk_campaign_claimant
        FOREIGN KEY (Claimant_claimant_id)
        REFERENCES Claimant (claimant_id),
    CONSTRAINT fk_campaign_qr_code
        FOREIGN KEY (Claimant_QR_code_qr_id)
        REFERENCES QR_code (qr_id)
);



CREATE TABLE Coupon (
    coupon_id INT IDENTITY(1,1) PRIMARY KEY,
    coupon_quantity INT,
    coupon_expiration_date DATE,
    coupon_number VARCHAR(45) UNIQUE,
    Claimant_claimant_id INT,
    Campaign_campaign_id INT,
    QR_code_qr_id INT,
    Coupon_Item_coupon_item_id INT,
    Coupon_Offer_coupon_offer_id INT,
    Coupon_Type_coupon_type_id INT,
    INDEX fk_coupon_claimant_idx (Claimant_claimant_id ASC),
    INDEX fk_coupon_campaign_idx (Campaign_campaign_id ASC),
    INDEX fk_coupon_qr_code_idx (QR_code_qr_id ASC),
    INDEX fk_coupon_item_idx (Coupon_Item_coupon_item_id ASC),
    INDEX fk_coupon_offer_idx (Coupon_Offer_coupon_offer_id ASC),
    INDEX fk_coupon_type_idx (Coupon_Type_coupon_type_id ASC),
    CONSTRAINT fk_coupon_claimant
        FOREIGN KEY (Claimant_claimant_id)
        REFERENCES Claimant (claimant_id),
    CONSTRAINT fk_coupon_campaign
        FOREIGN KEY (Campaign_campaign_id)
        REFERENCES Campaign (campaign_id),
    CONSTRAINT fk_coupon_qr_code
        FOREIGN KEY (QR_code_qr_id)
        REFERENCES QR_code (qr_id),
    CONSTRAINT fk_coupon_item
        FOREIGN KEY (Coupon_Item_coupon_item_id)
        REFERENCES Coupon_Item (coupon_item_id),
    CONSTRAINT fk_coupon_offer
        FOREIGN KEY (Coupon_Offer_coupon_offer_id)
        REFERENCES Coupon_Offer (coupon_offer_id),
    CONSTRAINT fk_coupon_type
        FOREIGN KEY (Coupon_Type_coupon_type_id)
        REFERENCES Coupon_Type (coupon_type_id)
);



CREATE TABLE Issuer (
    issuer_id INT IDENTITY(1,1) PRIMARY KEY,
    issuer_username VARCHAR(45),
    issuer_pwd VARBINARY(50),
    issuer_email VARCHAR(45),
    last_login DATETIME,
    issuer_profile VARCHAR(45),
    issuer_private_key VARBINARY(256),
    issuer_public_key VARBINARY(256),
    default_encryption TINYINT,
    Campaign_campaign_id INT,
    Coupon_coupon_id INT,
    INDEX fk_issuer_campaign_idx (Campaign_campaign_id ASC),
    INDEX fk_issuer_coupon_idx (Coupon_coupon_id ASC),
    CONSTRAINT fk_issuer_campaign
        FOREIGN KEY (Campaign_campaign_id)
        REFERENCES Campaign (campaign_id),
    CONSTRAINT fk_issuer_coupon
        FOREIGN KEY (Coupon_coupon_id)
        REFERENCES Coupon (coupon_id)
);



CREATE TABLE Vendor (
    vendor_id INT IDENTITY(1,1) PRIMARY KEY,
    vendor_username VARCHAR(45),
    vendor_pwd VARBINARY(50),
    vendor_email VARCHAR(45),
    last_login DATETIME,
    vendor_profile VARCHAR(45),
    vendor_private_key VARBINARY(256),
    vendor_public_key VARBINARY(256),
    user_role VARCHAR(45)
);


CREATE TABLE coupon_redeemed_list (
    coupon_redeemed_list_id INT IDENTITY(1,1) PRIMARY KEY,
    coupon_number VARCHAR(45),
    redemption_date DATETIME,
    redemption_status VARCHAR(10) CHECK (redemption_status IN ('redeemed', 'pending')),
    vendor_id INT,
    INDEX fk_coupon_redeemed_list_vendor_idx (vendor_id),
    CONSTRAINT fk_coupon_redeemed_list_vendor
        FOREIGN KEY (vendor_id)
        REFERENCES Vendor (vendor_id)
);
