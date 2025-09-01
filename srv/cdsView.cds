using { khaled.db as db  } from '../db/viewAll';

service cdsView @(path: 'cdsView') {

    entity viewAll as projection on db.viewAll;
}