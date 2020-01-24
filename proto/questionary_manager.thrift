include "base.thrift"
include "questionary.thrift"

namespace java com.rbkmoney.questionary.manage
namespace erlang questionary_manager

// id анкеты
typedef base.ID QuestionaryID
// id владельца анкеты
typedef base.ID OwnerID

typedef i64 Version

exception QuestionaryNotFound {}

exception QuestionaryNotValidException {}

exception QuestionaryVersionConflict {}

/**
* Маркер вершины истории
*/
struct Head {}

union Reference {
    1: Version version
    2: Head head
}

struct Snapshot {
    1: Version version
    2: Questionary questionary
}

struct Questionary {
    1: required QuestionaryID    id
    2: required OwnerID          owner_id
    3: required QuestionaryData  data
}

struct QuestionaryParams {
    1: required QuestionaryID    id
    2: required OwnerID          owner_id
    3: required QuestionaryData  data
}

/* Содержание анкеты */
struct QuestionaryData {
    1: optional questionary.Contractor   contractor
    2: optional questionary.BankAccount  bank_account
    3: optional questionary.ShopInfo     shop_info
    4: optional questionary.ContactInfo  contact_info
}

/**
* Сервис для работы с анкетами
*/
service QuestionaryManager {

    Version Save(1: QuestionaryParams params, 2: Version version)
        throws (
            1: QuestionaryNotValidException ex1,
            2: QuestionaryVersionConflict ex2
        )

    Snapshot Get(1:QuestionaryID questionaryId, 2: Reference reference) throws (1: QuestionaryNotFound ex)

}
