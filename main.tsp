import "@typespec/http";

using Http;

@error
model Error {
  code: int32;
  message: string;
}

@service(#{ title: "Widget Service" })
namespace DemoService {
  model Widget {
    id: string;
    weight: int32;
    color: "red" | "blue";
  }

  model WidgetList {
    items: Widget[];
  }

  model AnalyzeResult {
    id: string;
    analysis: string;
  }

  @route("/widgets")
  @tag("Widgets")
  interface Widgets {
    /** List widgets */
    @get list(): WidgetList | Error;
    /** Read widgets */
    @get read(@path id: string): Widget | Error;
    /** Create a widget */
    @post create(@body body: Widget): Widget | Error;
    /** Update a widget */
    @patch update(@path id: string, @body body: MergePatchUpdate<Widget>): Widget | Error;
    /** Delete a widget */
    @delete delete(@path id: string): void | Error;

    /** Analyze a widget */
    @route("{id}/analyze") @post analyze(@path id: string): AnalyzeResult | Error;
  }
}

@service(#{ title: "User Service" })
namespace UserService {
  model User {
    id: string;
    name: string;
    email: string;
    age?: int32;
  }

  model UserList {
    items: User[];
  }

  @route("/users")
  @tag("Users")
  interface Users {
    /** List users */
    @get list(): UserList | Error;
    /** Read a user */
    @get read(@path id: string): User | Error;
    /** Create a user */
    @post create(@body body: User): User | Error;
    /** Update a user */
    @patch update(@path id: string, @body body: MergePatchUpdate<User>): User | Error;
    /** Delete a user */
    @delete delete(@path id: string): void | Error;
  }
}
