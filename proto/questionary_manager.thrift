include "base.thrift"
include "questionary.thrift"

namespace java com.rbkmoney.questionary.manage
namespace erlang questionary_manager

// id анкеты
typedef base.ID QuestionaryID
// id владельца анкеты
typedef base.ID OwnerID

exception QuestionaryNotFound {}

exception QuestionaryNotValidException {}

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

    Questionary Create(1: QuestionaryParams params)
        throws (
            1: QuestionaryNotFound ex1
            2: QuestionaryNotValidException ex2
        )

    Questionary Get(1: QuestionaryID id) throws (1: QuestionaryNotFound ex)

}
