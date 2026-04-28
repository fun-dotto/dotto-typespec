namespace FunchService {
  model MenuItem {
    id: string;
    date: plainDate;
    name: string;
    imageUrl: url;
    category: Category;
    prices: Price[];
  }

  model MenuItemRequest(
    date: plainDate;
    name: string;
    imageUrl: url;
    category: Category;
    prices: Price[];
  )

  model Price {
    /**
     * サイズ
     */
    size: Size;

    /**
     * 価格
     */
    price: int32;
  }

  enum Size {
    /**
     * 小
     */
    Small,

    /**
     * 中
     */
    Medium,

    /**
     * 大
     */
    Large,
  }

  enum Category {
    /**
     * セット・単品
     */
    SetAndSingle,

    /**
     * 丼・カレー
     */
    BowlAndCurry,

    /**
     * 麺
     */
    Noodle,

    /**
     * 副菜
     */
    Side,

    /**
     * デザート
     */
    Dessert,
  }
}
