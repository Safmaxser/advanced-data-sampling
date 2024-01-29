CREATE TABLE IF NOT EXISTS genres (
    PRIMARY KEY (genres_id),
	genres_id SERIAL             NOT NULL,
	name      VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS songwriter (
    PRIMARY KEY (songwriter_id),
	songwriter_id SERIAL      NOT NULL,
	pseudonym     VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS singer_genres (
	songwriter_id INTEGER REFERENCES songwriter(songwriter_id),
	genres_id     INTEGER REFERENCES genres(genres_id),
	              CONSTRAINT pk_singer_genres
                  PRIMARY KEY (songwriter_id, genres_id)
);

CREATE TABLE IF NOT EXISTS album (
    PRIMARY KEY (album_id),
	album_id     SERIAL      NOT NULL,
	name         VARCHAR(50) NOT NULL,
	release_date DATE,
                 CONSTRAINT rd_album_correct
                 CHECK (release_date >= '1900-01-01')
);

CREATE TABLE IF NOT EXISTS singer_album (
	songwriter_id INTEGER REFERENCES songwriter(songwriter_id),
	album_id      INTEGER REFERENCES album(album_id),
	              CONSTRAINT pk_songwriter_album
                  PRIMARY KEY (songwriter_id, album_id)
);

CREATE TABLE IF NOT EXISTS collection (
    PRIMARY KEY (collection_id),
	collection_id SERIAL      NOT NULL,
	name          VARCHAR(50) NOT NULL,
	release_date  DATE,
                  CONSTRAINT rd_collection_correct
                  CHECK (release_date >= '1900-01-01')
);

CREATE TABLE IF NOT EXISTS track (
    PRIMARY KEY (track_id),
	track_id SERIAL      NOT NULL,
	album_id INTEGER     NOT NULL REFERENCES album(album_id),
	name     VARCHAR(50) NOT NULL,
	duration INTEGER,
             CONSTRAINT duration_correct
             CHECK (duration > 0)
);

CREATE TABLE IF NOT EXISTS track_collection (
	collection_id INTEGER REFERENCES collection(collection_id),
	track_id      INTEGER REFERENCES track(track_id),
	              CONSTRAINT pk_track_collection
                  PRIMARY KEY (collection_id, track_id)
);